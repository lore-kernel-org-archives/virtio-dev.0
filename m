Return-Path: <virtio-dev-return-14314-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB1DC48BC1
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 11:30:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 553882B146
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 11:30:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 223449865C3
	for <virtio-dev@archiver.kernel.org>; Wed, 14 Feb 2024 11:30:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF28898658E; Wed, 14 Feb 2024 11:30:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF1F498658F
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Feb 2024 11:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mD1RMwCsPUink3FefYxXJg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707910224; x=1708515024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+JlxetLqGfgXIuO+M860n27Ubw/CGDuUo/QeS89UmM=;
        b=kO+arTlz0iMCrCxFBpn71F3T1D5YaDE0QsHkUqUKq9OOmaU4FJoMI1X4IMJC75if6S
         p0IAPkk/7DgunvhdSr2/H3V91Tmaue7V9QvkFdq5oNS11niX0Kr8TnT68N3wJiOCy2oJ
         ndgyS925bDHa/iMcmAkp277SQRsyKg+kaM5NVOltIGRxM078oxIF1DHCoYJ/G0CR7co8
         vp7hYAJlTwPyLWPCUB5/MpqJawvDg0RlI0A5aI/yCoom57clsAuqz6fr5cy/NkitAxzP
         bwTrsJue9V6PhS4oUrqM3FJGll8KFByx0mUfSKIOLFW5qRM47rWS+LfoI3bvElPqF9G1
         9FvA==
X-Forwarded-Encrypted: i=1; AJvYcCVRXfmT2KBUONucs/SUeMtkfC8xDMmAj1vx23crhHXT+9b0wGe9An2m+ImnRR9SEahn3QoS2ebRi01Yb9Q224B/sxoHDnl5RPZBbS0kdkr4
X-Gm-Message-State: AOJu0Yxn2M8vlvzI5fPxY+dslgGKLQ50NaQMN9LSng9ufUYxDG6TYFEp
	h9sbpMXl0dBwQ6hXgi5b1xuvkyufop4Hgsx4/PALi5pP8i3Il1As1zGgrY1Bu6fuhJuHJ9e2yoC
	jfQJG3prAAQK2p/7WgvwSVEZoEHeJFnaGkIb+mfiskTZYoFOUrZ4+7zB6sarL/hMYXw==
X-Received: by 2002:a5d:6ac3:0:b0:33c:e323:ce39 with SMTP id u3-20020a5d6ac3000000b0033ce323ce39mr1560149wrw.43.1707910224270;
        Wed, 14 Feb 2024 03:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn/7CRCNOkTTcJ4FiqDJfiAfmidzS77K5Cp7PsBHxs2ygLXQq31lQk0BgMb5mWCWD9xGG0qA==
X-Received: by 2002:a5d:6ac3:0:b0:33c:e323:ce39 with SMTP id u3-20020a5d6ac3000000b0033ce323ce39mr1560128wrw.43.1707910223905;
        Wed, 14 Feb 2024 03:30:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDnOrhIMIku8GYfeG5v1QLOIsqpsWLfcFAOxVRTDhWd4QHsJdvn9P/TrtDxxxBc5KEnbVU6j3LWFAgjhA1jUcxp0j32JICPff8+5mX7ke+dqKNjuPGzOi0r3t9rXz9ZrkKP3IOSMM73xsEmNcdk3Br2n7mU2CLbwbFwadQowLPHTmDYFMei2PBySartjQ7qVVffGVKBNNspJnDCQA33QhmhyfShe2Ov1Vfv94C3JkXVHYkJUoo5o6VbuKYmi1st5dmbWrMiZI7VJFotHgrnDIO7eG96f7NfrGTNgDZUjUaq49+bDKxHftvXzUS8hK+BGdysLHtSQcnr2WW9PKk4jyacZVONaQ1unbKeGlva3vCkh+/41CY9jyXysZ4BnkrMDIrW3pCazO+tOomCvo47s2hM6OVxxBFtFHMccATLCMXWLYN
Date: Wed, 14 Feb 2024 06:30:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <Aiswarya.Cyriac@opensynergy.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
Message-ID: <20240214062348-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
 <20240213035806-mutt-send-email-mst@kernel.org>
 <FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.

On Wed, Feb 14, 2024 at 09:08:26AM +0000, Aiswarya Cyriac wrote:
> Hi Michael,
> 
> Thank you for reviewing. I have updated my response inline
> 
> On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> >> Fix the following warning when building virtio_snd driver.
> >>
> >> "
> >> *** CID 1583619:  Uninitialized variables  (UNINIT)
> >> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> >> 288
> >> 289         break;
> >> 290       }
> >> 291
> >> 292       kfree(tlv);
> >> 293
> >> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> >> vvv     Using uninitialized value "rc".
> >> 294       return rc;
> >> 295     }
> >> 296
> >> 297     /**
> >> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> >> 299      * @snd: VirtIO sound device.
> >> "
> >>
> >> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> >> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> >> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> >> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> >> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> >I don't know enough about ALSA to say whether the patch is correct.  But
> >the commit log needs work: please, do not "fix warnings" - analyse the
> >code and explain whether there is a real issue and if yes what is it
> >and how it can trigger. Is an invalid op_flag ever passed?
> >If it's just a coverity false positive it might be ok to
> >work around that but document this.
> 
> This warning is caused by the absence of the "default" branch in the
> switch-block, and is a false positive because the kernel calls
> virtsnd_kctl_tlv_op() only with values for op_flag processed in
> this block.

Well we don't normally have functions validate inputs.
In this case I am not really sure we should bother
with adding dead code. If you really want to, add BUG_ON.



> I will update the fix and send a v2 patch
> 
> >> ---
> >>  sound/virtio/virtio_kctl.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> >> index 0c6ac74aca1e..d7a160c5db03 100644
> >> --- a/sound/virtio/virtio_kctl.c
> >> +++ b/sound/virtio/virtio_kctl.c
> >> @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> >>                else
> >>                        rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> >>
> >> +             break;
> >> +     default:
> >> +             virtsnd_ctl_msg_unref(msg);
> >> +             rc = -EINVAL;
> >> +
> 
> >There's already virtsnd_ctl_msg_unref call above.
> >Also don't we need virtsnd_ctl_msg_unref on other error paths
> >such as EFAULT?
> >Unify error handling to fix it all then?
> 
> This also need to be handled and virtsnd_ctl_msg_unref needed in case of EFAULT as well.
> I will update the patch.
> 
> 
> Thanks,
> Aiswarya Cyriac
> Software Engineer
> ​
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> EMail: aiswarya.cyriac@opensynergy.com
> 
> www.opensynergy.com
> Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616B
> Geschäftsführer/Managing Director: Régis Adjamah
> 
> ________________________________________
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 13, 2024 10:06 AM
> To: Aiswarya Cyriac
> Cc: jasowang@redhat.com; perex@perex.cz; tiwai@suse.com; linux-kernel@vger.kernel.org; alsa-devel@alsa-project.org; virtualization@lists.linux-foundation.org; virtio-dev@lists.oasis-open.org; Anton Yakovlev; coverity-bot
> Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
> 
> On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> > Fix the following warning when building virtio_snd driver.
> >
> > "
> > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > 288
> > 289         break;
> > 290       }
> > 291
> > 292       kfree(tlv);
> > 293
> > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > vvv     Using uninitialized value "rc".
> > 294       return rc;
> > 295     }
> > 296
> > 297     /**
> > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > 299      * @snd: VirtIO sound device.
> > "
> >
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> I don't know enough about ALSA to say whether the patch is correct.  But
> the commit log needs work: please, do not "fix warnings" - analyse the
> code and explain whether there is a real issue and if yes what is it
> and how it can trigger. Is an invalid op_flag ever passed?
> If it's just a coverity false positive it might be ok to
> work around that but document this.
> 
> 
> > ---
> >  sound/virtio/virtio_kctl.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> > index 0c6ac74aca1e..d7a160c5db03 100644
> > --- a/sound/virtio/virtio_kctl.c
> > +++ b/sound/virtio/virtio_kctl.c
> > @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
> >               else
> >                       rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> >
> > +             break;
> > +     default:
> > +             virtsnd_ctl_msg_unref(msg);
> > +             rc = -EINVAL;
> > +
> 
> There's already virtsnd_ctl_msg_unref call above.
> Also don't we need virtsnd_ctl_msg_unref on other error paths
> such as EFAULT?
> Unify error handling to fix it all then?
> 
> >               break;
> >       }
> >
> > --
> > 2.43.0
> 
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

