Return-Path: <virtio-dev-return-14317-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D7DC48BC3
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 15:36:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CBAC92B147
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 15:36:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2716986596
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 15:36:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9940D98658F; Wed, 14 Feb 2024 15:36:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 898E5986590
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2024 15:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: TKCLe4nLNh6rPZVZf3U_2w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924966; x=1708529766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk+r5+Jl2RkVcClg72bssLx2pLXyZ58wrDSewZoLn+8=;
        b=IuioGwtjdAdzgBtbtCpa6JNhzBCLiox5mV/cVD+hun3uFirPz2clKDnDDCLl1C5Hk9
         VpnhOW4ZSY3hDHKTxEeZYkOfDinjq5rKyDMTvtWQBUBKDtXwCOl3dWdAwfA8LVE8gZ/Q
         dXq2Q7Y7iJF/0981PHM+JC2huHRODbuzyJvihrwnRgtFfe2vOjJNRTKvApsF6aiGGJi1
         pwDOPiZSh19B2GytCtgy9R6NAUzTjzTc4Y6K9F50hIoeHUHs+hio3dEWyPgIp846ztLW
         Kw3CmGztUsDRXN/RgT9L3nQPG6RL6tWuCEiTLIjOf45P/zS6dVkpb82MY1NBuC5QRVsr
         yvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiaoAcjg7TPmQm67cy04zWLCSe8wF33O8Xfbkj2+HLnMv3t65OI+UznohZKlzmezYdXN6dWhMNfrjLip/uvAGbiUU7Q5pwmzBsaPLcpwVI
X-Gm-Message-State: AOJu0YyBT8DP/kSmaeZFyHGy2RFv2VX7uT5B4Mdp6GgfepbduVHWVK5M
	XQbzES9jGNXmpBx1O/bYQqUiDzm3v/l5neRL6KCdOEOxlW3C42gQpEvDMsU11cX+1bDF6pLvKYF
	WpTPaXq9PHWe9vYUkD61sAAhLM4gsuVMsILofbcK+8sRuxEHAU4a6b7v+o3b6o8kmfw==
X-Received: by 2002:adf:f588:0:b0:33c:d8ac:c182 with SMTP id f8-20020adff588000000b0033cd8acc182mr2030152wro.41.1707924966165;
        Wed, 14 Feb 2024 07:36:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN4rsvb3h0+DO6dhzov4nViL7vH02SlEqXlo+Dh8Cvpkddkjlq+Lr8v5C5Scgn75uJes+DVg==
X-Received: by 2002:adf:f588:0:b0:33c:d8ac:c182 with SMTP id f8-20020adff588000000b0033cd8acc182mr2030138wro.41.1707924965759;
        Wed, 14 Feb 2024 07:36:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVw1n6ntQ1Pnj6sCIZ79pFaffBrcPDQR2hDKsPPQZ9IaU/EWNYc2o+8XL7GMNl3hIEGE+3WhvWomNOtpns6/JE0L9GvLXFqZ06y4TTX2o5b3SzR33+bwq/J3EzYnJenvTfpD1Rq/3fOERcPkQqoveY0/BZeMuHKmpEkWP0NsVzTgGo9VQt8gH7huNpHKP5p3ninOeLsg0bTAoryzv5Wbn5ah+1BJjpfEm90i3vf/XoSU/0hcVaMjfUcoxRyd4HEzhhXjVirHBBthb5gt1V4nMutvxDgH5T+uj2hllvq2MTuG3YKawnJhDx/5Wi6hsV/Vl6q/1jZtjLwN+SqRG+outmBHFRXluLJu/muoACgCOJwT3Dlwm9vZM8a7Q==
Date: Wed, 14 Feb 2024 10:36:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Message-ID: <20240214102727-mutt-send-email-mst@kernel.org>
References: <20240214140110.606171-1-aiswarya.cyriac@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20240214140110.606171-1-aiswarya.cyriac@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [v3 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.

On Wed, Feb 14, 2024 at 03:01:10PM +0100, Aiswarya Cyriac wrote:
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
>  sound/virtio/virtio_kctl.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..40606eb381af 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  
>  	tlv = kzalloc(size, GFP_KERNEL);
>  	if (!tlv) {
> -		virtsnd_ctl_msg_unref(msg);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto on_cleanup;
>  	}
>  
>  	sg_init_one(&sg, tlv, size);
> @@ -266,6 +266,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  	case SNDRV_CTL_TLV_OP_READ:
>  		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
>  
> +		/* Since virtsnd_ctl_msg_send() drops the reference, we increase
> +		 * the counter to be consistent with the on_cleanup path.
> +		 */


This is not how multi-line comments should look.


Adding overhead here is just a waste of cycles.
Instead, separate error handling and normal exit paths.
Then you will not need to increase the refcount here.

> +		virtsnd_ctl_msg_ref(msg);
> +
>  		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
>  		if (!rc) {
>  			if (copy_to_user(utlv, tlv, size))
> @@ -281,14 +286,26 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  			hdr->hdr.code =
>  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
>  
> -		if (copy_from_user(tlv, utlv, size))
> +		if (copy_from_user(tlv, utlv, size)) {
>  			rc = -EFAULT;
> -		else
> +		} else {
> +			/* Same as the comment above */

Same thing.
Besides, this kind of cross referencing breaks immediately when
someone adds a comment in the middle.

> +			virtsnd_ctl_msg_ref(msg);
> +
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> +		}
> +
> +		break;
> +	default:
> +		rc = -EINVAL;


	/* We never get here - we listed all values for op_flag */

> +		WARN_ON(1);
>  
>  		break;
>  	}
>  
> +on_cleanup:
> +	virtsnd_ctl_msg_unref(msg);
> +
>  	kfree(tlv);
>  
>  	return rc;

on_cleanup is not informative, coding style says:
"Choose label names which say what the goto does or why the goto
exists."

And saving on duplication here by paying elsewhere does not make sense.
So you do this instead:


  	kfree(tlv);
  	return rc;

on_error:
	virtsnd_ctl_msg_unref(msg);
 	kfree(tlv);
 	return rc;


This is very ideomatic.

> -- 
> 2.43.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

