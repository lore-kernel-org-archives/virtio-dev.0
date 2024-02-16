Return-Path: <virtio-dev-return-14325-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1759C48260
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 11:27:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2D3B6120D41
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 11:27:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12EF3986652
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 11:27:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EE1FC9865FD; Fri, 16 Feb 2024 11:27:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDD349865FF
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Feb 2024 11:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: G23VVBZxMlK9iLz_wq5ebQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082873; x=1708687673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldTgol2RjHwGuL7/gP1WBAM77N/i279/pdvnyHeoM1E=;
        b=bnb47J21yjagOWz89iDS+KAnjPU0Vqlfir/cwCcTGh+yK+TjbqGwsVcTIDXwjAEBsk
         X1gBEf62TZQ58vmjmncTc0XaEuo9UGJ7u4XQC3RE8Z2XOpit1BiNKEJ73K2acq3gCDYl
         gevvbj0eQxWsIlIJr+Nc6deBcS7/Hp+cCHKTB5R6c4tz0RFd+MFuCXj/qT1zuDGcQWuT
         XL0CexZA3Yuz/s2wIbSVNRI1quiOsooB7rzEbatvYtYzejJEy8Y3hsXHMioYbcTiEPzL
         pwYnqwxRx+iRPUbVJWpO9QkBNhRqlS2dWBJohITlGt92XXPB15CXPd3Q/0LsG1MBei4x
         u4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3VQZr82sMzxcymwxWGWJif3X5H6a8CswxIKGWQicqeoBijP4FDcGZAEmmSUhJqm9JkvM8sX/jMysil5Ry65ncOUJpi0T0vZ/CJVlsfRJ8
X-Gm-Message-State: AOJu0Yz+lDpO7vmuBf+WoxjFxhbm1zAktVczd07rv81Byr3/41akA2S2
	Afe6E9FxJboi+IE7RCHCs0FxR03WqgE2dJNxZ9npERYe47KzAcqMWZdc3burhCQ4B3uD9aDOmcS
	AZntA2BXTGPSXDxsr2M5Z8UDVauDIYgKv13sGT2SxfBkEt1MCqnsrMGaqhD9vD++F2A==
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr3738288wrj.26.1708082872837;
        Fri, 16 Feb 2024 03:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgaY3PtAN8z8RgLWyK9s4sch0JhbTy5FoXAS+RRg2r8qkUw3EqgzlI0lsRkHqGluoJTNtjKA==
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr3738275wrj.26.1708082872447;
        Fri, 16 Feb 2024 03:27:52 -0800 (PST)
Date: Fri, 16 Feb 2024 06:27:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Message-ID: <20240216062630-mutt-send-email-mst@kernel.org>
References: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [v4 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.

On Fri, Feb 16, 2024 at 11:06:43AM +0100, Aiswarya Cyriac wrote:
> This commit fixes the following warning when building virtio_snd driver.
> 
> "
> *** CID 1583619:  Uninitialized variables  (UNINIT)
> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> 288
> 289     		break;
> 290     	}
> 291
> 292     	kfree(tlv);
> 293
> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "rc".
> 294     	return rc;
> 295     }
> 296
> 297     /**
> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> 299      * @snd: VirtIO sound device.
> "
> 
> This warning is caused by the absence of the "default" branch in the
> switch-block, and is a false positive because the kernel calls
> virtsnd_kctl_tlv_op() only with values for op_flag processed in
> this block.
> 
> Also, this commit unifies the cleanup path for all possible control
> paths in the callback function.
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")



> ---
>  sound/virtio/virtio_kctl.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..7aa79c05b464 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  
>  	tlv = kzalloc(size, GFP_KERNEL);
>  	if (!tlv) {
> -		virtsnd_ctl_msg_unref(msg);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto on_msg_unref;
>  	}
>  
>  	sg_init_one(&sg, tlv, size);
> @@ -281,14 +281,25 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  			hdr->hdr.code =
>  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
>  
> -		if (copy_from_user(tlv, utlv, size))
> +		if (copy_from_user(tlv, utlv, size)) {
>  			rc = -EFAULT;
> -		else
> +			goto on_msg_unref;
> +		} else {
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> +		}
>  
>  		break;
> +	default:
> +		rc = -EINVAL;
> +		/* We never get here - we listed all values for op_flag */
> +		WARN_ON(1);
> +		goto on_msg_unref;
>  	}
> +	kfree(tlv);
> +	return rc;
>  
> +on_msg_unref:
> +	virtsnd_ctl_msg_unref(msg);
>  	kfree(tlv);
>  
>  	return rc;

I don't really like adding code for a false-positive but ALSA
maintainers seem to like this. If yes, this seems like as good
a way as any to do it.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> 2.43.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

