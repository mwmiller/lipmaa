defmodule LipmaaTest do
  use ExUnit.Case
  doctest Lipmaa

  test "error conditions" do
    assert Lipmaa.linkseq(0) == :error
    assert Lipmaa.linkseq(-1) == :error
    assert Lipmaa.linkseq("one") == :error
    assert Lipmaa.linkseq(Integer.pow(2, 64)) == :error
  end

  test "vectors from lipmaa-link.rs" do
    assert Lipmaa.linkseq(1) == 0
    assert Lipmaa.linkseq(2) == 1
    assert Lipmaa.linkseq(3) == 2
    assert Lipmaa.linkseq(4) == 1
    assert Lipmaa.linkseq(5) == 4
    assert Lipmaa.linkseq(6) == 5
    assert Lipmaa.linkseq(7) == 6
    assert Lipmaa.linkseq(8) == 4
    assert Lipmaa.linkseq(9) == 8
    assert Lipmaa.linkseq(10) == 9
    assert Lipmaa.linkseq(11) == 10
    assert Lipmaa.linkseq(12) == 8
    assert Lipmaa.linkseq(13) == 4
    assert Lipmaa.linkseq(14) == 13
    assert Lipmaa.linkseq(15) == 14
    assert Lipmaa.linkseq(16) == 15
    assert Lipmaa.linkseq(17) == 13
    assert Lipmaa.linkseq(18) == 17
    assert Lipmaa.linkseq(19) == 18
    assert Lipmaa.linkseq(20) == 19
    assert Lipmaa.linkseq(21) == 17
    assert Lipmaa.linkseq(22) == 21
    assert Lipmaa.linkseq(23) == 22
    assert Lipmaa.linkseq(24) == 23
    assert Lipmaa.linkseq(25) == 21
    assert Lipmaa.linkseq(26) == 13
    assert Lipmaa.linkseq(27) == 26
    assert Lipmaa.linkseq(28) == 27
    assert Lipmaa.linkseq(29) == 28
    assert Lipmaa.linkseq(30) == 26
    assert Lipmaa.linkseq(31) == 30
    assert Lipmaa.linkseq(32) == 31
    assert Lipmaa.linkseq(33) == 32
    assert Lipmaa.linkseq(34) == 30
    assert Lipmaa.linkseq(35) == 34
    assert Lipmaa.linkseq(36) == 35
    assert Lipmaa.linkseq(37) == 36
    assert Lipmaa.linkseq(38) == 34
    assert Lipmaa.linkseq(39) == 26
    assert Lipmaa.linkseq(40) == 13
    assert Lipmaa.linkseq(121) == 40
  end

  test "cert_pool" do
    assert Lipmaa.cert_pool(1) == [1]
    assert Lipmaa.cert_pool(4) == [4, 1]
    assert Lipmaa.cert_pool(11) == [13, 12, 11, 10, 9, 8, 4, 1]

    assert Lipmaa.cert_pool(1_024) == [
             1093,
             1092,
             1091,
             1090,
             1050,
             1049,
             1036,
             1035,
             1031,
             1027,
             1026,
             1025,
             1024,
             1023,
             1010,
             970,
             849,
             728,
             364,
             121,
             40,
             13,
             4,
             1
           ]
  end
end
