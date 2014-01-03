#!/usr/bin/perl

# ******************************************************
# Software name :convert jpeg to pdf (複数のjpeg ファイルをpdfに変換)
# jpg2pdf.pl
# version 0.1 (2010/December/07)
# version 0.2 (2012/March/10)
# version 0.3 (2012/October/09)
#
# Copyright (C) 2010-2012, INOUE Hirokazu
#     http://oasis.halfmoon.jp/
# Copyright (C) 2012, Shinnosuke Suzuki <sasasin@sasasin.net>
#
# GNU GPL Free Software
#
# このプログラムはフリーソフトウェアです。あなたはこれを、フリーソフトウェア財
# 団によって発行された GNU 一般公衆利用許諾契約書(バージョン2か、希望によっては
# それ以降のバージョンのうちどれか)の定める条件の下で再頒布または改変することが
# できます。
# 
# このプログラムは有用であることを願って頒布されますが、*全くの無保証* です。
# 商業可能性の保証や特定の目的への適合性は、言外に示されたものも含め全く存在し
# ません。詳しくはGNU 一般公衆利用許諾契約書をご覧ください。
# 
# あなたはこのプログラムと共に、GNU 一般公衆利用許諾契約書の複製物を一部受け取
# ったはずです。もし受け取っていなければ、フリーソフトウェア財団まで請求してく
# ださい(宛先は the Free Software Foundation, Inc., 59 Temple Place, Suite 330
# , Boston, MA 02111-1307 USA)。
#
# http://www.opensource.jp/gpl/gpl.ja.html
# ******************************************************

use strict;
use warnings;
use utf8;

use File::Basename;
use PDF::Create;
use Image::Size;
use Encode::Guess qw/euc-jp shiftjis iso-2022-jp/;
use File::Glob;
use Getopt::Std;

my $flag_os = 'linux';  # linux/windows
my $flag_charcode = 'utf8';     # utf8/shiftjis

# IOの文字コードを規定
if($flag_charcode eq 'utf8'){
    binmode(STDIN, ":utf8");
    binmode(STDOUT, ":utf8");
    binmode(STDERR, ":utf8");
}
if($flag_charcode eq 'shiftjis'){
    binmode(STDIN, "encoding(sjis)");
    binmode(STDOUT, "encoding(sjis)");
    binmode(STDERR, "encoding(sjis)");
}

my $strBaseDir = './';        # （入力jpegファイル）基準ディレクトリ
my $strInputScanPath = './*.jpg';   # 入力ファイルの検索パス
my $strOutputFilename = './output.pdf'; # 出力 PDF
my $strAuthor = '';
my $strTitle='';
my $strPaperSize = 'A4';

my @arrFiles = ();  # 画像ファイルの配列

#print("\n".basename($0)." - 複数のjpeg ファイルをpdfに変換\n\n");

my %option = ();
getopts("d:o:s:a:t:", \%option);

sub_user_input_init();

# ファイルへの書き込みが出来るか検査する
open(FH, ">".sub_conv_to_local_charset($strOutputFilename)) or die($strOutputFilename."に書き込めません\n$!");
close(FH);

sub_make_pdf();

#print("PDF作成終了\n");

exit();


# 初期データの入力
sub sub_user_input_init {

    if($#ARGV == 1 && length($ARGV[0])>1 && length($ARGV[1])>1)
    {
        $strBaseDir = sub_conv_to_flagged_utf8($ARGV[0]);
        $strOutputFilename = sub_conv_to_flagged_utf8($ARGV[1]);
    }

    # 対象ディレクトリの入力
    if($#ARGV >= 0 && length($ARGV[0])>1)
    {
        $strBaseDir = sub_conv_to_flagged_utf8($ARGV[0]);
    }
    
    unless(defined $option{'d'})
    {
	print("入力jpgファイルの格納ディレクトリを、絶対または相対ディレクトリで入力。\n".
	      "（例：/home/user/, ./）[$strBaseDir] :");
	$_ = <STDIN>;
	chomp();
	unless(length($_)<=0){ $strBaseDir= $_; }
    }
    else
    {
	$strBaseDir = sub_conv_to_flagged_utf8($option{'d'});
    }

    if(substr($strBaseDir,-1) ne '/'){ $strBaseDir .= '/'; }  # ディレクトリは / で終わるように修正
    unless(-d sub_conv_to_local_charset($strBaseDir)){ die("終了（理由：ディレクトリ ".$strBaseDir." が存在しません）\n"); }
    #print("入力ディレクトリ : " . $strBaseDir . "\n");

    $strInputScanPath = $strBaseDir . '*.jpg';
    #print("対象jpeg検索パス : " . $strInputScanPath . "\n");

    # 出力pdfファイル名の入力
    if($#ARGV >= 1 && length($ARGV[1])>1)
    {
        $strOutputFilename = sub_conv_to_flagged_utf8($ARGV[1]);
    }

    unless(defined $option{'o'})
    {
	print("出力PDFファイルのフルパスを入力。\n".
	      "（例：/home/user/012.pdf, ./012.pdf）[$strOutputFilename] :");
	$_ = <STDIN>;
	chomp();
	unless(length($_)<=0){ $strOutputFilename= $_; }
    }
    else
    {
	$strOutputFilename = sub_conv_to_flagged_utf8($option{'o'});
    }

    if(-d sub_conv_to_local_charset($strOutputFilename)){ die("終了（理由：$strOutputFilename はディレクトリです）\n"); }
    unless($strOutputFilename =~ m/(^\/|^.\/)/){ $strOutputFilename = "./".$strOutputFilename; }
    #print("出力ファイル : $strOutputFilename\n");

    if($flag_charcode ne 'utf8'){ print("***PDF属性の日本語はうまく処理されない場合があります***\n"); }

    if(defined $option{'a'})
    {
	$strAuthor = sub_conv_to_flagged_utf8($option{'a'});
    }
    #print("Author : " . $strAuthor . "\n");

    if(defined $option{'t'})
    {
	$strTitle = sub_conv_to_flagged_utf8($option{'t'});
    }
    #print("Title : " . $strTitle . "\n");

    # 用紙サイズの入力
    if($option{'s'})
    {
	$strPaperSize = $option{'s'}
    }
    #print("用紙サイズ : " . $strPaperSize . "\n");

}


# jpeg から pdf を作成する
sub sub_make_pdf{

    # 入力ファイルを検索して、配列に格納する。
    @arrFiles = File::Glob::glob(sub_conv_to_local_charset($strInputScanPath));
    @arrFiles = sort(@arrFiles);
    if($#arrFiles < 0){ die("対象ファイルが見つからない\n"); }
    printf("対象ファイル数：%d個\n", $#arrFiles+1);

    #print("PDF作成を開始します。\n");

    # initialize PDF  （AuthorとTitleの日本語処理は不完全。windowsの場合文字化け有り）
    my $pdf = new PDF::Create('filename'     => sub_conv_to_local_charset($strOutputFilename),
			      'Version'  => 1.3,
			      'Author'       => ($strAuthor ne '' ? Encode::encode('utf16', $strAuthor) : ''),
			      'Title'        => ($strTitle ne '' ? Encode::encode('utf16', $strTitle) : ''),
			      'CreationDate' => [ localtime ], );

    # 用紙をポートレート（縦＞横）で置いた場合のPDFサイズ
    my $width_paper = $pdf->get_page_size($strPaperSize)->[2];  # 用紙 横サイズ
    my $height_paper = $pdf->get_page_size($strPaperSize)->[3]; # 用紙 縦サイズ

    foreach(@arrFiles){

        my $strImageFile = sub_conv_to_flagged_utf8($_);
        my ($width, $height) = imgsize(sub_conv_to_local_charset($strImageFile));
        if(!defined($width) || !defined($height) || $width <= 0 || $height <= 0){
            die("ファイル $strImageFile の縦横ピクセル数が読み取れない");
        }
        #print($strImageFile."\n");

        # ページ幅を用紙サイズに合わせるための比率
        my $nRatio;
        my $x;      #PDF出力横
        my $y;      #PDF出力縦
        if($width < $height){
            # 用紙縦置き
            if($height_paper/$width_paper < $height/$width){
                # 基準より縦長 → 縦が「用紙サイズ縦」に収まるように比率決定
                $nRatio = $height_paper / $height;
            }
            else{
                # 基準より横長 → 横が「用紙サイズ横」に収まるように比率決定
                $nRatio = $width_paper / $width;
            }
            $x = int($width*$nRatio);
            $y = int($height*$nRatio);
        }
        else{
            # 用紙横置き
            if($height_paper/$width_paper < $width/$height){
                # 基準より横長 → 横が「用紙サイズ縦」に収まるように比率決定
                $nRatio = $height_paper / $width;
            }
            else{
                # 基準より縦長 → 縦が「用紙サイズ横」に収まるように比率決定
                $nRatio = $width_paper / $height;
            }
            $x = int($width*$nRatio);
            $y = int($height*$nRatio);
        }

        # 新しいページを追加
        my $container = $pdf->new_page('MediaBox' => [0, 0, $x, $y]);
    
        my $page = $container->new_page();

        # 画像を読み込んで貼りつけ
        my $image = $pdf->image(sub_conv_to_local_charset($strImageFile));
        $page->image('image' => $image, 'xpos' => 0, 'ypos' => 0, 'xscale' => $nRatio, 'yscale' => $nRatio);
    }

    # Close the file and write the PDF
    $pdf->close;

    # 日本語メタデータの書き込み試行 → いまのところエラー
#   my $pdf2 = PDF::API2->open(sub_conv_to_local_charset($strOutputFilename));
#   $pdf2->info(
#       'Author'       => ($strAuthor ne '' ? Encode::encode('utf16', $strAuthor) : '') ,
#       'Title'       => ($strTitle ne '' ? Encode::encode('utf16', $strTitle) : '')
#       );
#   $pdf2->update;

}


# 任意の文字コードの文字列を、UTF-8フラグ付きのUTF-8に変換する
sub sub_conv_to_flagged_utf8{
    my $str = shift;
    my $enc_force = undef;
    if(@_ >= 1){ $enc_force = shift; }      # デコーダの強制指定
    
    # デコーダが強制的に指定された場合
    if(defined($enc_force)){
        if(ref($enc_force)){
            $str = $enc_force->decode($str);
            return($str);
        }
        elsif($enc_force ne '')
        {
            $str = Encode::decode($enc_force, $str);
        }
    }

    my $enc = Encode::Guess->guess($str);   # 文字列のエンコードの判定

    unless(ref($enc)){
        # エンコード形式が2個以上帰ってきた場合 （shiftjis or utf8）
        my @arr_encodes = split(/ /, $enc);
        if(grep(/^$flag_charcode/, @arr_encodes) >= 1){
            # $flag_charcode と同じエンコードが検出されたら、それを優先する
            $str = Encode::decode($flag_charcode, $str);
        }
        elsif(lc($arr_encodes[0]) eq 'shiftjis' || lc($arr_encodes[0]) eq 'euc-jp' || 
            lc($arr_encodes[0]) eq 'utf8' || lc($arr_encodes[0]) eq 'us-ascii'){
            # 最初の候補でデコードする
            $str = Encode::decode($arr_encodes[0], $str);
        }
    }
    else{
        # UTF-8でUTF-8フラグが立っている時以外は、変換を行う
        unless(ref($enc) eq 'Encode::utf8' && utf8::is_utf8($str) == 1){
            $str = $enc->decode($str);
        }
    }

    return($str);
}


# 任意の文字コードの文字列を、UTF-8フラグ無しのUTF-8に変換する
sub sub_conv_to_unflagged_utf8{
    my $str = shift;

    # いったん、フラグ付きのUTF-8に変換
    $str = sub_conv_to_flagged_utf8($str);

    return(Encode::encode('utf8', $str));
}


# UTF8から現在のOSの文字コードに変換する
sub sub_conv_to_local_charset{
    my $str = shift;

    # UTF8から、指定された（OSの）文字コードに変換する
    $str = Encode::encode($flag_charcode, $str);
    
    return($str);
}
