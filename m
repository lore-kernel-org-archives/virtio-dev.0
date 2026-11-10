Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312116;
	b=eed+88AWjUoA9hF2S5PLsNz3pxu3xyvx4JGkG4FbAyZUDn1G4lJzNJw9ddCdm8lF3Xn1
	 h1bKTFfLqCMPlQNernec2P5KkSOcfWdqTydL5K7l2Tq4BVRJ3mTRATN04CgdOsg9P8pc1
	 u4QhjrESouPO7hlM5whbtXCBeEzonJFiueIRDCS2jzUL4na+3hOgJ45SeLTNGhdVXi+Jf
	 zkS/ELjFUvqR7veomILrwbm9PLwPgTz5ORndieQzcbjHXp5V4nFURXUC8VN99EhfDdHe9
	 2aZJ060+P6O6KR9etqW4TYolSLBR+C1Njnl5IaIbWYBono6018ye6lAyYOf+FrWzmEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312116;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition;
	bh=aHVatP+PBSHpASpPx9emfaOtam7U2QyVJYK/ubiBmyk=;
	b=AdI+rd9y2aamHnJWgnSd/Qi1QKVxIC20sPr6z1ULvcjNNeQ/pmCS0t9MY2p2iEt9Gte5
	 Q4fkqdGdVXKn8g+3BjdBrdl8USB8c351akoNM1DHJ5BkpvrjLXNZTCPy0nwdzrhGEyOoh
	 LOk/yx4wKVnc7FAebAf7yz7gBplyoiNmbSe1K2gcd7nw4O6QCorb0rdZIl7yI9J0PnAt7
	 RvtEpxZ8efM4BzoQrmi/BnBOVdg3oCbRv9EZvt+1OXJ7drJhBx3Vtl1UnY/9QVCDy9V7d
	 Cs+91rDFG/qkqHVmT/nmehHCA4t3IlbVNVNo8bRWtNhKyg7vS0W4/dTfMfKMnG8fdCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JVooaD83;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D39606A31C
	for <virtio-dev@lists.linux.dev>; Tue, 10 Nov 2026 12:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JVooaD83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794312115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHVatP+PBSHpASpPx9emfaOtam7U2QyVJYK/ubiBmyk=;
	b=JVooaD83g9/6eYzMBHl+UAcrtk44mF3JLZjp7ElzHcbMGWu6pmWkSaJdfH2PQaUFm0JvBQ
	+DwUeChTbH3Hk7unlpygN3SHGarl7dpT6B9SO0upb/xhFpa8sNudC0MI1f6a0p/r72xWUC
	7K7+6Mo0ZaCCw5keJsn9DfP0P5vRUhg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-C45qbFbHOqaPQQ0jhTYqpw-1; Tue, 10 Nov 2026 07:01:51 -0500
X-MC-Unique: C45qbFbHOqaPQQ0jhTYqpw-1
X-Mimecast-MFC-AGG-ID: C45qbFbHOqaPQQ0jhTYqpw_1794312110
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49febef74e3so13340025e9.0
        for <virtio-dev@lists.linux.dev>; Tue, 10 Nov 2026 04:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312110; x=1794916910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHVatP+PBSHpASpPx9emfaOtam7U2QyVJYK/ubiBmyk=;
        b=YGP1lnUVCTk5FFeAKl8kORC/yqVkLxChtTCDXz+bqwNk5YvOunUdtldejdg39J8FKl
         eIwD+MntB5JuoACMyuQFOwy797qj6lHijZlHXscXWcXfWWgWHWsYFZtvunbKvoN51S69
         VoW6oR1t1o5QuNvcaLnesZUoJWve52fsMbY+BT/R8sIgl9vfWqjWMLG/IgnVXeLa6Ebc
         RrYdEoeIpt/uNbP8c/UhYE5s2f2xczF6cqKmne6MfIMQuKO4q8MdNkxT8nfrCrVCT0yU
         EaC+xDPsK9HPbFBFDQGH9LTbzINwLCXb163UWHBI0h4NIY++djEiDXmcLd3IHQ9DpuuG
         ZHZQ==
X-Gm-Message-State: APuU4Z/QrY53m4ow7hYj+dazGzLKOIUeep+dDapquDGmGJ8YnAaiLu3g
	6iYH40zi949f8YuKOfVwsbdIIMqRPkDQ6Mxw5K1PN8ADYcgVl/gVf05IKMVgqEBwx9lIr7p7Pck
	DcFWZ00cWHlsYXcXrgRDMwUyd2HooqiImlr7rFVuB82bSpg0j+E1ysc499m+pYpo=
X-Gm-Gg: AYBFou3tl7suUWuh7sSMnbJB6drVQxZTo+JiqXSove2v1DDH3J5RG4Si660yUjZKSpV
	gCYlBvopA5ScrJlBnAEIsdt7+BDI+lObb91+t2stjLlmxFa2b92fDC/tLa0ulqkSFJnifnb1ZMo
	Ozxwnz3gdTHnyZfw+3lRtri8uci1G3Zs1IwZ9OrDy0W6fdjJzqvQalTh5JBgVzEtOG4Iq0sOsZl
	SbuZXgTfWHBgMGxjbEl/JAMrHkNE55yOWnr2QqI8hxb5s7WVSbvw05cIIZGjp3SEUp+aVdRTeME
	Cx/1TiZc1VZsDakemLfmJHeUx8M/IeY0AUm1O9EhysPXN3YzNpzuZ6rGrCONhntkf2NKg+56XDX
	xuQSISZpqzLrHlCSlRSAoHSkjhI6elz+DDgdi620cOw==
X-Received: by 2002:a05:600c:6087:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4ba0233cbbbmr38078815e9.3.1794312110020;
        Tue, 10 Nov 2026 04:01:50 -0800 (PST)
X-Received: by 2002:a05:600c:6087:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4ba0233cbbbmr38078335e9.3.1794312109368;
        Tue, 10 Nov 2026 04:01:49 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01feee1asm77131865e9.12.2026.11.10.04.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:01:48 -0800 (PST)
Date: Tue, 10 Nov 2026 07:01:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, virtio-comment@lists.linux.dev,
	stefanha@redhat.com, mgurtovoy@nvidia.com, parav@nvidia.com,
	ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v6 4/4] virtio-blk: Add inline encryption security
 considerations
Message-ID: <20261110065058-mutt-send-email-mst@kernel.org>
References: <20261027090945.185178-1-linlin.zhang@oss.qualcomm.com>
 <20261027090945.185178-5-linlin.zhang@oss.qualcomm.com>
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Post: <mailto:virtio-dev@lists.linux.dev>
List-Help: <mailto:virtio-dev+help@lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtio-dev+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027090945.185178-5-linlin.zhang@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJRIaT8-2S1vIVGV4OnkeRQofHWEY1bk8rbDdYyKo8U_1794312110
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Good start! Yet something to improve:

On Tue, Oct 27, 2026 at 02:09:27AM -0700, Linlin Zhang wrote:
> Inline encryption protects the data stored on the backend storage, but
> the device, and therefore the host, is able to read the buffers of both
> the request virtqueues and the administration virtqueue.
> 
> Describe the resulting exposure. The data of the requests is transferred
> in plaintext, so inline encryption is not a means of keeping data
> confidential from the host, whichever key type is used, and confidential
> guests cannot rely on it for that.
> 
> A raw key programmed into a keyslot is visible to the host. A
> hardware-wrapped key prevents the raw key from being extracted, so that
> the key can only be used through the device which wrapped it, but does
> not prevent the host, which is able to send administration commands
> itself, from using the key through the device.
> The raw key imported by VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY and the
> software secret returned by VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET
> are also visible to the host.
> 
> This patch adds no normative requirements.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>


This needs to be rewritten:
- use terminology from spec (or standards linked to) do not make up your
  own
- address physical device implementations and software ones
- specific recommendations lacking

> ---
>  device-types/blk/description.tex | 40 ++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> index bbae9af..ca54e50 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -1994,6 +1994,46 @@ \subsubsection{Inline Encryption Administration Commands}\label{sec:Device Types
>  NOT write key material or the derived software secret to the
>  \field{command_specific_result}.
>  
> +\subsubsection{Inline Encryption Security Considerations}\label{sec:Device Types / Block Device / Device Operation / Inline Encryption Security Considerations}
> +
> +Inline encryption protects the data stored on the backend storage, for
> +example against an attacker who obtains the storage medium on its own. It
> +is not a means of keeping data confidential from the host: the device, and
> +therefore the host, is able to read the buffers of both the request
> +virtqueues and the administration virtqueue. A confidential guest, for
> +example a guest whose memory is protected from the host by a confidential
> +computing technology, cannot rely on inline encryption to keep its data
> +confidential from the host, whichever key type it uses.


Pls reword in terms of device/driver, not host/guest.
"confidential guest" is also not a common term

E.g. "an untrusted device", "a driver that does not trust the device".
You can give examples "e.g. as is common with
confidential computing configurations".

this applies everywhere.

> +
> +\begin{note}
> +Inline encryption does not protect the data of VIRTIO_BLK_T_CRYPTO_OUT and
> +VIRTIO_BLK_T_CRYPTO_IN requests from the host: that data is transferred in
> +plaintext in buffers of the request virtqueues.
> +\end{note}
> +
> +When \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW, the key material in
> +the \field{bytes} of struct virtio_blk_crypto_key_desc of a
> +VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command is the plaintext key.

the plaintext key?

> +Any software able to access the buffers of the administration virtqueue,
> +such as the hypervisor, the device implementation or other software on the
> +host, can therefore obtain the key, and decrypt the data encrypted with it
> +at any time, including after the key is no longer in use.

what does it have to do with software, unclear.

> +
> +When \field{key_type} is VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED, a
> +VIRTIO_BLK_ADMIN_CMD_CRYPTO_KEYSLOT_PROGRAM command only transfers a key
> +wrapped by the device, and the raw key material is not exposed in its
> +buffers.

material?

the considerations are same or different for different key types?
pls structures the text to make it clear what applies to what.


> This prevents the raw key from being extracted, so that the key
> +can only be used through the device which wrapped it. It does not prevent
> +the host, which is able to send administration commands itself, from using
> +the key through the device, for example by converting a long-term wrapped
> +key it has observed with VIRTIO_BLK_ADMIN_CMD_CRYPTO_PREPARE_KEY and
> +programming the result into a keyslot. Moreover, a
> +VIRTIO_BLK_ADMIN_CMD_CRYPTO_IMPORT_KEY command carries the raw key in its
> +\field{command_specific_data}, and the struct virtio_blk_crypto_sw_secret
> +returned by a VIRTIO_BLK_ADMIN_CMD_CRYPTO_DERIVE_SW_SECRET command is
> +visible in its \field{command_specific_result}, so these commands expose
> +secrets to the host in the same way as raw keys.


this seems to argue with itself about some kind of protection
that maybe could be there but is not?


> +
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_req
> -- 
> 2.34.1

