Return-Path: <virtio-dev-return-14326-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9753CC48260
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 13:49:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D0E80148F86
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 13:49:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2E77986666
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Feb 2024 13:49:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B1D849865FF; Fri, 16 Feb 2024 13:49:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A25F8986602
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Feb 2024 13:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: c9BePlS3PnqrrUZRmgy88w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091335; x=1708696135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHwFSfupJsy1hRAlGeBjUd3fBxQOvPgv40N7Q7XfS68=;
        b=YS/Uh70PWwOVnMMEqvm8qYaNkQ7qsMSUn5kO10ybhbIULse/Dvfc9EyffwhCOANpvA
         5lTO7euJi/Rt+hVc+H6uVtghrSQ9gRTAtytDUkV2K+977HAB6GjH1z3gyz8ctsTNQlvA
         0pUnFd6B+cZqYu82CW4AoNor49Kf31o+oDLcAzD6Kzw9p/fBs5vLMiEfWGZrnn7IL9bv
         +Jyhisx9z2ZsiD2jiuBJblZ4xki3kurDVp5S4kddMWkm9V+E5wTOb8ptxFRSnslTf5Kp
         gPI5K+GrohnSXBSTvwQtOa1DrPskS0mravavBXpwpr5smXbcPiCgXVAmfe1aORWdlgGV
         FjXw==
X-Forwarded-Encrypted: i=1; AJvYcCWPwSg7je3l9P6xbwze8AgEljflpDHsqjc0H8h8zKHGwMQHOyuGPHEaD6neKn1Wlg+Lirv0QRhZCuCjZdbVcKnFExTNSky2ZDv5YKEl6zW0
X-Gm-Message-State: AOJu0Yw+DM5ZtWF716czsjU4wwJP9GyL5ygmynpkUzCBYOoP8vtLd+tb
	m59w91ayJUIMYzII0eZPByU/DoX+gZebHmYZwTVEVUxMZYUL/Dk2MKWHmcdhkiBYiNd7jOMcvHD
	B4XZxEy6MeIvM7QhXvxhLXJ5aKZH5iZwahKwq3UXDstUIWTYF4ZgSK1mfUB7Of5OquQ==
X-Received: by 2002:adf:a446:0:b0:33d:4e5:b1f2 with SMTP id e6-20020adfa446000000b0033d04e5b1f2mr2846250wra.38.1708091335569;
        Fri, 16 Feb 2024 05:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKRiyhBRn3dqC1O4++DJPl4UeczabTxLsvRYTNlOGCoRxMyc7ZUtF2wusHbWzsZjImqCuLnA==
X-Received: by 2002:adf:a446:0:b0:33d:4e5:b1f2 with SMTP id e6-20020adfa446000000b0033d04e5b1f2mr2846231wra.38.1708091335123;
        Fri, 16 Feb 2024 05:48:55 -0800 (PST)
Date: Fri, 16 Feb 2024 08:48:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>, jasowang@redhat.com,
	perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Message-ID: <20240216084610-mutt-send-email-mst@kernel.org>
References: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
 <20240216062630-mutt-send-email-mst@kernel.org>
 <87eddcikz6.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <87eddcikz6.wl-tiwai@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [v4 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.

On Fri, Feb 16, 2024 at 02:42:37PM +0100, Takashi Iwai wrote:
> On Fri, 16 Feb 2024 12:27:48 +0100,
> Michael S. Tsirkin wrote:
> > 
> > On Fri, Feb 16, 2024 at 11:06:43AM +0100, Aiswarya Cyriac wrote:
> > > This commit fixes the following warning when building virtio_snd driver.
> > > 
> > > "
> > > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > > 288
> > > 289     		break;
> > > 290     	}
> > > 291
> > > 292     	kfree(tlv);
> > > 293
> > > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > > vvv     Using uninitialized value "rc".
> > > 294     	return rc;
> > > 295     }
> > > 296
> > > 297     /**
> > > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > > 299      * @snd: VirtIO sound device.
> > > "
> > > 
> > > This warning is caused by the absence of the "default" branch in the
> > > switch-block, and is a false positive because the kernel calls
> > > virtsnd_kctl_tlv_op() only with values for op_flag processed in
> > > this block.
> > > 
> > > Also, this commit unifies the cleanup path for all possible control
> > > paths in the callback function.
> > > 
> > > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> > 
> > 
> > 
> > > ---
> > >  sound/virtio/virtio_kctl.c | 19 +++++++++++++++----
> > >  1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> > > index 0c6ac74aca1e..7aa79c05b464 100644
> > > --- a/sound/virtio/virtio_kctl.c
> > > +++ b/sound/virtio/virtio_kctl.c
> > > @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> > >  
> > >  	tlv = kzalloc(size, GFP_KERNEL);
> > >  	if (!tlv) {
> > > -		virtsnd_ctl_msg_unref(msg);
> > > -		return -ENOMEM;
> > > +		rc = -ENOMEM;
> > > +		goto on_msg_unref;
> > >  	}
> > >  
> > >  	sg_init_one(&sg, tlv, size);
> > > @@ -281,14 +281,25 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> > >  			hdr->hdr.code =
> > >  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
> > >  
> > > -		if (copy_from_user(tlv, utlv, size))
> > > +		if (copy_from_user(tlv, utlv, size)) {
> > >  			rc = -EFAULT;
> > > -		else
> > > +			goto on_msg_unref;
> > > +		} else {
> > >  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> > > +		}
> > >  
> > >  		break;
> > > +	default:
> > > +		rc = -EINVAL;
> > > +		/* We never get here - we listed all values for op_flag */
> > > +		WARN_ON(1);
> > > +		goto on_msg_unref;
> > >  	}
> > > +	kfree(tlv);
> > > +	return rc;
> > >  
> > > +on_msg_unref:
> > > +	virtsnd_ctl_msg_unref(msg);
> > >  	kfree(tlv);
> > >  
> > >  	return rc;
> > 
> > I don't really like adding code for a false-positive but ALSA
> > maintainers seem to like this. If yes, this seems like as good
> > a way as any to do it.
> 
> Err, no, you misunderstood the situation.
> 
> I took the v1 patch quickly because:
> - It was with Anton's SOB, who is another maintainer of the driver
> - I assumed you lost interest in this driver since you haven't reacted
>   to the previous patches for long time
> - The change there was small and simple enough
> 
> Now, it grows unnecessarily large, and yet you complained.  Why should
> I take it, then?
> 
> This is a subtle cosmetic issue that isn't worth for wasting too much
> time and energy.  If we want to shut up the compile warning, and this
> is a case where it can't happen, just put the "default:" to the
> existing case.  If you want to be user-friendly, put some comment.
> That's all.  It'll be a one-liner.
> 
> OTOH, if we do care and want to catch any potential logical mistake,
> you can put WARN().  But, this doesn't have to go out as an error.
> Simply putting WARN() for the default and going through would work,
> too.
> 
> Or we can keep this lengthy changes if we want, too.
> 
> So, I really don't mind which way to fix as long as it works correctly
> (and doesn't look too ugly).  Please make agreement among you guys,
> and resubmit if needed.
> 
> 
> thanks,
> 
> Takashi

OK sorry about too verbose.  I mean since Anton wants it, I ack this.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

