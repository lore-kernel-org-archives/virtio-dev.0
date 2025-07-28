Received: from mx.kernkonzept.com (serv1.kernkonzept.com [159.69.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E7253350
	for <virtio-dev@lists.linux.dev>; Mon, 28 Jul 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.200.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695564; cv=none; b=EGpaJXUwyqAHavg3EdZnmoW+aytQDz5W2nui9IHz6iLNix+fM7Ka9epN/5syV4Mow+VyO+n5oapRK7mF7YOwiOLk+TbUo8PMInJm+tachqVC9ShyC7J5Acc4Zyo7JGvdGBH6xitUBZIkIA8ZCpdUGqHHBox0W0wRTPTkLrhKcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695564; c=relaxed/simple;
	bh=AGRyFFoTgFonuxIp4K8jeOqnMb4kQND+wuo4HbBQ9aM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fGcseGnbMpVyTmxFY0/Hpeys3D6yFgkJxtqL4Uli6tiCJfKxy8oVNkSdszb1QztwYKY/oNN6sbkss6MYe1AAJZmHvBeI/0OilH62Kd7igNYFJRmMkmbgvz+lgRhcNFAeiu0Q5EEF8oxJ5eQGs3J/DWLR2M8UoB9sfhi8Zt8ffuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernkonzept.com; spf=pass smtp.mailfrom=kernkonzept.com; dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.b=oMufaCfP; arc=none smtp.client-ip=159.69.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernkonzept.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="oMufaCfP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:References:In-Reply-To:Cc:Reply-To:
	Content-ID:Content-Description;
	bh=+8AutICEIDgcqZZ6KptLo1th5YYUY+B6G/PsTMfNp+w=; b=oMufaCfPibrA1n6+QeGWas3YRu
	lIKevY35OrB4VPTruNlBlyx52fZk+ikGwi/zrbJwhVjzpxz4xvE1/+vgFbrZKjNQ4+rEsMo6KxvfW
	QfmPWmj9iJljsL/J0KrgBMYJodo0Y6wZZT6xh9dcUZMINlDXCdYgQQ0wlnQFACdI+qgbLuc4uJe5V
	0QrQN83pS9ehrwV2bsmlOLTgHWbEfW+aofdw59ClQoRnEXT34OgxUTm11Dm4wejh7JH/OiwXrQUZH
	fvdjmG4gcvP8R8GYdtmi+r3FU9ftA7rjCzn2b3CG46RA/F2b31gqalVT8AOrs1aBMMMlTTy//XPo9
	XhtblrfQ==;
Received: from 89-24-36-96.nat.epc.tmcz.cz ([89.24.36.96] helo=[192.168.1.160])
	by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim 4.96)
	id 1ugKK8-00EFnU-0E
	for virtio-dev@lists.linux.dev;
	Mon, 28 Jul 2025 11:39:12 +0200
Message-ID: <6cc43c4a-dc4a-4f9a-a4f7-95004ac1ff99@kernkonzept.com>
Date: Mon, 28 Jul 2025 11:39:10 +0200
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: virtio-dev@lists.linux.dev
Content-Language: en-US
From: =?UTF-8?B?SmFrdWIgSmVybcOhxZk=?= <jakub.jermar@kernkonzept.com>
Subject: virtio-spi message boundaries
Autocrypt: addr=jakub.jermar@kernkonzept.com; keydata=
 xsDNBGGBBeIBDADSFYziAD42TkiJ1SWSe7/8Xxl+pzWXHH312dMoeoaLQ4kU6i8ZJWKLmtSX
 pFbOP5Bf7YQIMF8jA3fJrZpYoP8N21MAG2HJh/Rzygs5tUCBD4luDB+TOdbaN+kTg3fp76AW
 PbJYXt/z2nFWWLA61iUEG7AsQGD8mFROQLk9aAkWaqX+Gdayg8B3GDdNpcpm/qN7liXPi/CT
 rjKOGu3yMBuGTO40O461MlAZDdAfYLDzj3VkuCF0nMMqUDkdku0kcL8B9NZJMdwYJmxmEBy7
 8rfIprP+s13pKTdqr52/ci2/SWcKNIxDsDtoMpgSNSYst7KtfhCoEy0O+jG+1NhFH80GX9KE
 OwUfaZbPQdy5KQm2cm+W8laTTLfAdmwbwiPHo24KmbGgkUVvzn5yeK1/qk6U3r8WTgkbRpsg
 c+bLdhoZV6cpcf+kBcfOwcGwUllu9GRMq7mfkM6cojr05C+LC80mzlDoZovTeJXF2g1UJAMr
 ZejiSj/pU0gzOmxoLP0faokAEQEAAc0tSmFrdWIgSmVybcOhxZkgPGpha3ViLmplcm1hckBr
 ZXJua29uemVwdC5jb20+wsEJBBMBCAAzFiEEcj6fe7v3atnRJkfzFaSARiue+YIFAmGBBeIC
 GwMFCwkIBwIGFQgJCgsCBRYCAwEAAAoJEBWkgEYrnvmCa60MALwInUYT+IKLkmpZzvZYPecP
 fPybErhpJU31ghedRQmaGD6dfVDumXJhL1kWg8p98x/HdhAhbjJKokecinI7rA1w7ydS8Z1a
 S0M153k17xmCBVwNqUcxJTD1ARcKhJ+4EUkAuWylih6wiF2t6/90VaToLtm1NzxD2cbxa1u+
 m7/pZ+8U0pOcfUh/9nMCmGdydHzYzkQI/XEnHkiyhEGjuP+YPFoYVKORTVxMHHB4VrkZN4Og
 H1YwtYTgkxKBQNJPo0LncGytIzg9FUdS5vBE5CnXZEmuASZKRAcRgx+0R7462xyjI9s3d4eS
 E2Lw0otGeNgs9BLVH66xcdgWTlXgOeKdYIA+Ae6kNcpI+4EdUEmqptpTLLV9yOk3m2Oq11I7
 xL5X0zxGZM4s0+pdL/L/mNrz6DZENen0qhOhm6gQJ3Vi5ufgN/40I7q9gF+ok1ETNL6+SyK1
 Ow+dq/TwAL380Ofn/7d6fG+laqI08PXW4UMOE/jv674uAh/mA65GkizU/87AzQRhgQXjAQwA
 27Xjm10aD4SU+TdInnlgRKImuMz61Npz8guAiRB3L3HsBO6I9v17LcvtjtF1EaA9dubt7DYC
 omMPpE9yhtMUlt6V8eq3ONcJpwB8KiGR4LnC1x+8KfvmwCoObbIwbaBfcnjdRnvcYk1JzK7B
 SgP4tEREEk+q2Xmu9PcORq1eIc2v+X1zWMhol9ZQ1bQBiSqrzmwksrvgp4XenM6rVyOCNSZq
 uc648f510FDag+TAEMH/G1F6A9p0lnDEQifek9Tyy+Q9nbWBYjpNkXJY7adT0tQ9PC+QSEvk
 VmUzUCMfZE7idkOt8asjopSNHYWVaqm9qk4nuxmZinkpLv+trBCCcYkjFLfc+TnrpzN+9yu0
 VB+t1ekLoLKLg4RWFPjXS5lL6R8eVi91Z2kIsLRGV9blbGQzINwi+RX0cfy/a3ZToKWdv0ag
 47SSdKz1JrZgLSoOP4OnihWQW4dBUli3dVTKuEORIrGkLKHy5XVVZTjlnlxO/O4qt9Z3psmK
 UfXrAm1HABEBAAHCwPYEGAEIACAWIQRyPp97u/dq2dEmR/MVpIBGK575ggUCYYEF4wIbDAAK
 CRAVpIBGK575goxUC/4yHS/smaOvYnukckEvuMzXtiJyAZWkrX11FnSOKY4mvDv0kxfHijrq
 Ceb1WFoembsnlL+tm3n6Liy3d6ZdlpyMxerat73jNVXBSUe8tOjRXnnUZik6pT9dha4Zws4M
 Xim5MYQCz2BFDKeLwlYTzD0R3o5/bCzXzcimdIM4c8tjKRx2W6gFTaUc8t8N6en0TI9vGc14
 ANhiPPcHWbZpk5Botjh1i14kedG/iWSrR4z2j1HnBb5HOykTLuuPl1X6PmQPvFYISHH/2b21
 0ag6wbG1kl+Ni4Ry7BKc+23Y31aU/QTAE0l+1waniAec3F/NFjXGHkFIlt358pFP8cNbYPMj
 BKfNODYCLvDRTt3AuaRlgBxBenDNxREYC6+C4VWWAd/UArYU2qs5LV/rE66rkejAoG2VxtpF
 xSJP+hPAXL5EjZpkJumnEOkwanzp09D8v1k8U8xobNTjQpU/4xlCq70bzgK5DIrvK918gzOI
 mfn0wus50CqWrlr5mFNjBgWWlNc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

the current virtio-spi draft mentions the concept of SPI messages in
several places, for example:

  cs_change_supported indicates if the device supports to toggle
  chipselect after each transfer in one message: 0: unsupported,
  chipselect will be kept in active state throughout the message
  transaction; 1: supported.
  Note: Message here contains a sequence of SPI transfers.

and also:

  Note: Just as one message contains a sequence of transfers, one
  transfer may contain a sequence of words.

These wordings appeared in the virtio-spi device specification patch v5
and have remained in the specification draft ever since. I was, however,
unable to find any discussion that preceded their introduction into the
spec (as far as the concept of messages themselves is concerned).

Now, I was wondering how does the virtio-spi device figure out which SPI
transfers belong to the same SPI message. SPI messages are important
wrt. to correct toggling of the chip select line but the spec is quite
vague on how to find their boundaries.

I could imagine, for example, that an SPI message is formed by chaining
the respective virtio-spi transfers of a message together so that a
message is determined by the head descriptor of the first transfer. But
this is not stated anywhere. I was hoping to be able to infer this from
the proposed virtio-spi Linux driver, but it does not seem to handle
messages at all in its latest version.

Has anyone figured this out already?

Cheers,
Jakub
