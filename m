Return-Path: <virtio-dev-return-14300-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5408C48260
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 09:06:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ED80D2AEE1
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 09:06:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C60E0986497
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 09:06:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B0F8D986436; Tue, 13 Feb 2024 09:06:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A140A98644C
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Feb 2024 09:06:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RvVKv49aNcKyOklyJGXlQw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815172; x=1708419972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCp+U2tcizd8TQvjWI973O/2/xnroOwuTJofpoENFck=;
        b=lcVYLbjwX7HwOYJh/sSbQmkyOGB2Nts2DaCwPT46unEbYZyVb/xy87Ctr2bAAnRNd7
         LQmD5obytoVENBrEo344jnCCzB3yTGZS8FXjKzQXMx/ycce4VAVLmoFU44VjSJnLIwAy
         bPLYgBzn51xVjoxtZ133KeEPBqBAovPgBzEhRttqOwYptclDeTC6duePuWFIJJPJ/DTp
         ooipRJFd86PkvufRUOs4K0m1xwjbezRqeDG0jAaKaAe5UO4yDQgTv/YTTf6QtW29tWFi
         oG5tu5wF8MbmuD9gBW4OBQU3YgDsgOo+kzpMNWOJ/Cbfq9r5uiTCYqwxzbqjOVLcm8Io
         9Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCXYpFbiu6KzxbWLbD5EJVgfMLwubRQQIeuqFD7noDoj63RjwChGpT7qv02bDxDS4YNEYMd/3oiqnXwwvMPdG51jnNuj+cu6juBve23IXzQE
X-Gm-Message-State: AOJu0YwoyDKztIy4McrmsQ3722NqDwkl72Om51J95kQorqhFdCRGXmq4
	sMv97K2IczWz39Zk6VHQiuJ2xOYib/Yd7SFOfquCRvsWDaQRRKUOYes2BKd0XyNqhSPO5lpa4A8
	V6xYhUFSB5Csaeuz7I3BEFEoithl913Ba+iwplXkIKpkblvmjzglqx+oL09K2gUiBGw==
X-Received: by 2002:a05:6402:22ec:b0:561:f77b:c0b0 with SMTP id dn12-20020a05640222ec00b00561f77bc0b0mr622567edb.39.1707815171937;
        Tue, 13 Feb 2024 01:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1WxLIbkc9509MADVuZj12YdZkQRBE5ZevDuhFcjxgdr1fVp4moBUIGKQf1C7kGw0aY3jCDA==
X-Received: by 2002:a05:6402:22ec:b0:561:f77b:c0b0 with SMTP id dn12-20020a05640222ec00b00561f77bc0b0mr622553edb.39.1707815171594;
        Tue, 13 Feb 2024 01:06:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsT77fnhrOLUZtwRFl10XYMgZvpCowT2ftQ62g+EnJpk2swblqtcfEL6k9x+GqRZCAjwwyLRx7YRIXccqc4d9awtdWl3QMp0jpWut2UdWzxp+RMY813l3jOGxex+j+KSI+IBR4UL2N1MM9barmOwALJI3DV2VJzQdhXEZcmoqETaKg7DdzxZDzWLJcKNwkHjC2K3Rk1L0kA9mQBrkKjAOQb2BlPWN7/67oXqABJW6pUlMcRZbpCwjkay3Jl7+MLJSrn65kRoPxuttBje9z2eEl6TIhmpsWavi932jiB07eRMUe79h16bcZvxNrKwYn0JanD4ZmadQ2cNm2V0GKs5dl2R1tG5Hm7Sr2ZGJIFkLcuVtwxdUPjt5UUQ==
Date: Tue, 13 Feb 2024 04:06:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Message-ID: <20240213035806-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.

On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> Fix the following warning when building virtio_snd driver.
> 
> "
> *** CID 1583619:  Uninitialized variables  (UNINIT)
> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> 288
> 289         break;
> 290       }
> 291
> 292       kfree(tlv);
> 293
> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "rc".
> 294       return rc;
> 295     }
> 296
> 297     /**
> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> 299      * @snd: VirtIO sound device.
> "
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")

I don't know enough about ALSA to say whether the patch is correct.  But
the commit log needs work: please, do not "fix warnings" - analyse the
code and explain whether there is a real issue and if yes what is it
and how it can trigger. Is an invalid op_flag ever passed?
If it's just a coverity false positive it might be ok to
work around that but document this.


> ---
>  sound/virtio/virtio_kctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..d7a160c5db03 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  		else
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
>  
> +		break;
> +	default:
> +		virtsnd_ctl_msg_unref(msg);
> +		rc = -EINVAL;
> +

There's already virtsnd_ctl_msg_unref call above.
Also don't we need virtsnd_ctl_msg_unref on other error paths
such as EFAULT?
Unify error handling to fix it all then?

>  		break;
>  	}
>  
> -- 
> 2.43.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

