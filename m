Received: from mx.kernkonzept.com (serv1.kernkonzept.com [159.69.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70DD238D42
	for <virtio-dev@lists.linux.dev>; Wed, 10 Sep 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.200.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501512; cv=none; b=qn7TjzRZSHe9FGnokv5c0x5//+SMLeZs+UVPV4jk9iKjYZPvDgqEpqJnwlT1RKe0VA/qJjSHex51g/ayUWfBIFyDhAV6zSUxdS93fsvA2ByY9AH7SY4M7pCS+/d04aLmkUF414F4q29yuaA+C+HbICbLWP1xFILDsSF3vOn0ZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501512; c=relaxed/simple;
	bh=kvaHF4CI6ia20pQco9P73jtfwC7tV9mFM6L48QsKtR4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=iKwGEWudOay9OHaf6vSWOycTx42S1PSpNM2Ppvd2N14A3g9wB8d5b5Db/R5CQTI+zEvpeH+UtzdFguHM1sHanZeSooGFkTCytyIjZMf/z/xH5vZDGf+cZfpHxrwGZ7mw1Jt4MCq24VrtUKxoeEiMU115/SkxBtzdXvg8Lyr2XVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernkonzept.com; spf=pass smtp.mailfrom=kernkonzept.com; dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.b=k1+BbVia; arc=none smtp.client-ip=159.69.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernkonzept.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="k1+BbVia"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Cc:
	Reply-To:Content-ID:Content-Description;
	bh=72cQU2bX5uPRQZ1EHqoxuCv+nCmS7Za0IQwcIqoFAhM=; b=k1+BbViaZibZl2BgbP7z0+ox+0
	t9INFm2RfKnLUaaSUkpyVjqE6nX4rw5stCrniv5eSSIT7J693AhTnphQcBDKY9OzEWuVZUIblg21r
	S2h6GQbEgsw4NYhiT0W13ktBuu8Vkdh5HoZlzlXsaKh5kfFkDfuH3LPMMaaBXyddXLsiFguQ+tHbR
	XcfGIuc1THivKPbkId0ZZdNFfP5FYz2VhUSeaX8Be96vls7zWpHShY97Kwi6qT4R8LuBYkoZOWUPf
	qgBoPuQuyX4JfHFYXf9LS9m7bsGq5dyZxuH/KrubvfMPNiud7j5lZU3cGfmBolbJ86HmVc8KsOEAa
	ZXQHk0Gw==;
Received: from 78-80-18-0.customers.tmcz.cz ([78.80.18.0] helo=[192.168.1.160])
	by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim 4.96)
	id 1uwI4Q-00EZct-1I
	for virtio-dev@lists.linux.dev;
	Wed, 10 Sep 2025 12:28:58 +0200
Message-ID: <49ac47f5-178b-4f93-8ac4-f7bd35bea535@kernkonzept.com>
Date: Wed, 10 Sep 2025 12:28:56 +0200
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio-spi message boundaries
From: =?UTF-8?B?SmFrdWIgSmVybcOhxZk=?= <jakub.jermar@kernkonzept.com>
To: virtio-dev@lists.linux.dev
References: <6cc43c4a-dc4a-4f9a-a4f7-95004ac1ff99@kernkonzept.com>
Content-Language: en-US
Autocrypt: addr=jakub.jermar@kernkonzept.com; keydata=
 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
 mfn0wus50CqWrlr5mFNjBgWWlNc=
In-Reply-To: <6cc43c4a-dc4a-4f9a-a4f7-95004ac1ff99@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

since there was no reply to this, let me try to rephrase the perceived
shortcoming of the specification more concisely.

It seems to me that the current spec and the proposed Linux driver do
not allow the VIRTIO SPI device implemented according to this spec to
figure out the exact SPI message boundaries.

I have a Linux VM running the VIRTIO SPI driver. It is connected via
VIRTIO SPI to a real-world bmp280 device driven by our native VIRTIO SPI
device driver (which is out of the Linux VM). The problem is that any
information about SPI message boundaries is lost in the VIRTIO SPI
protocol. BMP280 is sensitive to premature chip-select disabling as it
forgets what it was doing before and switches to I2C mode immediately
when CS goes inactive. With the current VIRTIO SPI spec, every transfer
looks like a separate SPI message.

I was able to overcome this issue by slightly modifying the
specification (and also the Linux driver) to allow the last transfer of
an SPI message to be signaled in one of the reserved bytes of the VIRTIO
SPI transfer. Thus our device driver was able to reconstruct the SPI
message boundaries and deselect the CS correctly.

Am I overlooking some other mechanism that should be used to achieve the
same goal instead of my workaround?

Cheers,
Jakub


On 7/28/25 11:39 AM, Jakub Jermář wrote:
> Hello,
> 
> the current virtio-spi draft mentions the concept of SPI messages in
> several places, for example:
> 
>   cs_change_supported indicates if the device supports to toggle
>   chipselect after each transfer in one message: 0: unsupported,
>   chipselect will be kept in active state throughout the message
>   transaction; 1: supported.
>   Note: Message here contains a sequence of SPI transfers.
> 
> and also:
> 
>   Note: Just as one message contains a sequence of transfers, one
>   transfer may contain a sequence of words.
> 
> These wordings appeared in the virtio-spi device specification patch v5
> and have remained in the specification draft ever since. I was, however,
> unable to find any discussion that preceded their introduction into the
> spec (as far as the concept of messages themselves is concerned).
> 
> Now, I was wondering how does the virtio-spi device figure out which SPI
> transfers belong to the same SPI message. SPI messages are important
> wrt. to correct toggling of the chip select line but the spec is quite
> vague on how to find their boundaries.
> 
> I could imagine, for example, that an SPI message is formed by chaining
> the respective virtio-spi transfers of a message together so that a
> message is determined by the head descriptor of the first transfer. But
> this is not stated anywhere. I was hoping to be able to infer this from
> the proposed virtio-spi Linux driver, but it does not seem to handle
> messages at all in its latest version.
> 
> Has anyone figured this out already?
> 
> Cheers,
> Jakub

