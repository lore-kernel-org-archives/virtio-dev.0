Return-Path: <virtio-dev-return-14277-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74239C47258
	for <virtio-dev@archiver.kernel.org>; Thu, 25 Jan 2024 03:52:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9DE202AEE7
	for <virtio-dev@archiver.kernel.org>; Thu, 25 Jan 2024 03:52:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B23C9867F0
	for <virtio-dev@archiver.kernel.org>; Thu, 25 Jan 2024 03:52:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5BBF79867E4; Thu, 25 Jan 2024 03:52:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48CDD9867E5
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2024 03:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: -gxWTslyOHuc_yj7S0dB_g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706154723; x=1706759523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0nQVEEet9sDuHnQH+6ECm8Z3Y+GixgaPIbiMrpaFmg=;
        b=XwW5oSPlZn8v2T5Phu3Rj9Ee2ZHovtZmZSS4FpDi/RFrrhTAvmYfXrYX/AneaaU96P
         4yoj5NkNvzNBfu3K/dkPm2AuQ4QGVSLzghgZ6qs1gjUidrsarrRl2dDAKfoHIZL76Cau
         G9GGzV8Ll1F3Y0odsU9V07xDgnb2uXzU+adDwxdIGnNvW8nh54D4TcK5txUTEC68Y4Lg
         /Wwg1IVMGJ3KNitAL6uBY1shDr6gVHuU+cRrQWAjS46HprJwfLbE8SJv9HRugeBJwKiB
         2VTuFCBpJqyuBBzPzUGtPu7RfXuGO1hqDwr+JKfr1J3Ceqg3i+apyHwHDhILh7rmhDps
         89eQ==
X-Gm-Message-State: AOJu0Yy5UeQJDDSp9dTXGsvIWXQk2vVnIaQCdYocgqezvk/U/216Eip9
	wp3tGSU4m9oB2s65RAUaAr3aCZOqYJULOKpKRHV8WR0avKbGihnFzlvqgQJjbzyrevA80GwQTVZ
	Qs1XgkYFQYvRdAihWbTHuspza9Zcth1qYui95M4CKbn2EP7/HuaXu4dSk89s3SpYQqoTeGpSAc5
	IgV1mVvfjSL9fdB4RTiZlTcsq+D4BDYIqDa6McUUoV
X-Received: by 2002:a05:6808:1150:b0:3bd:ca60:c4cf with SMTP id u16-20020a056808115000b003bdca60c4cfmr259746oiu.71.1706154723124;
        Wed, 24 Jan 2024 19:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVV+UR9Ko6j9xG7DtzPzYdb9k5mCAP90hxCKemKdhVgOPf6Zj+dWNKjlWVVgOECnY2cs7QZlsEy+/EJOz6QPQ=
X-Received: by 2002:a05:6808:1150:b0:3bd:ca60:c4cf with SMTP id
 u16-20020a056808115000b003bdca60c4cfmr259739oiu.71.1706154722892; Wed, 24 Jan
 2024 19:52:02 -0800 (PST)
MIME-Version: 1.0
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com> <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
 <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com> <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078d541e-fac7-47ef-a69c-139d1e9b04f0@linux.alibaba.com> <PH0PR12MB54819844499B9D43865EDC4CDC7B2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <52cef8e6-f878-4927-ab77-f3b71d3df85d@linux.alibaba.com>
In-Reply-To: <52cef8e6-f878-4927-ab77-f3b71d3df85d@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:51:51 +0800
Message-ID: <CACGkMEt51UjK_xMjODcqjEzwDFGMcBDE+sf-omdJ=OA+De=rbQ@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] RE:
 [virtio-dev] RE: [virtio-comment] [PATCH v2] virtio-net: support setting
 coalescing params for multiple vqs

On Thu, Jan 25, 2024 at 11:05=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/1/24 =E4=B8=8B=E5=8D=889:18, Parav Pandit =E5=86=99=E9=81=
=93:
> >> From: Heng Qi <hengqi@linux.alibaba.com>
> >> Sent: Wednesday, January 24, 2024 6:31 PM
> >>
> >>
> >> =E5=9C=A8 2024/1/22 =E4=B8=8B=E5=8D=881:03, Parav Pandit =E5=86=99=E9=
=81=93:
> >>>> From: Heng Qi <hengqi@linux.alibaba.com>
> >>>> Sent: Monday, January 22, 2024 8:27 AM
> >>>>
> >>>> =E5=9C=A8 2024/1/20 =E4=B8=8B=E5=8D=885:59, Parav Pandit =E5=86=99=
=E9=81=93:
> >>>>>> From: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>> Sent: Wednesday, January 17, 2024 10:22 AM
> >>>>>>
> >>>>>> =E5=9C=A8 2024/1/15 =E4=B8=8B=E5=8D=889:21, Parav Pandit =E5=86=99=
=E9=81=93:
> >>>>>>>> From: virtio-comment@lists.oasis-open.org
> >>>>>>>> <virtio-comment@lists.oasis- open.org> On Behalf Of Heng Qi
> >>>>>>>> Sent: Monday, January 15, 2024 6:36 PM
> >>>>>>>>
> >>>>>>>> Currently, when each time the driver attempts to update the
> >>>>>>>> coalescing parameters for a vq, it needs to kick the device and
> >>>>>>>> wait for the ctrlq response to return.
> >>>>>>> It does not need to wait. This is some driver limitation that doe=
s
> >>>>>>> not use
> >>>>>> the queue as "queue".
> >>>>>>> Such driver limitation should be removed in the driver. It does
> >>>>>>> not qualify
> >>>>>> as limitation.
> >>>>>>
> >>>>>> Yes, we don't have to wait.
> >>>>>>
> >>>>>> But in general, for user commands, it is necessary to obtain the
> >>>>>> final results synchronously.
> >>>>> Yes. Use initiated command can enqueue the request to cvq. Go to
> >>>>> sleep
> >>>> for several micro to milliseconds.
> >>>>>> The user command cannot return before the final result is obtained=
.
> >>>>>> And wait is not the problem this patch solves.
> >>>>>>
> >>>>> By not holding the rtnl lock, rest of the context that needs to
> >>>>> enqueue the
> >>>> request can progress such as that of netdim.
> >>>>
> >>>> Would like to see the using of rtnl lock changed.
> >>>>
> >>> Inside the virtnet_rx_dim_work() there should be rtnl lock call.
> >>> A virtio_device level lock to be used for cvq. :)
> >>>
> >>>> In addition, I have made batching and asynchronousization of the
> >>>> netdim command, you can refer to this patch:
> >>>> https://lore.kernel.org/all/1705410693-118895-4-git-send-email-
> >>>> hengqi@linux.alibaba.com/
> >>>>
> >>> In the listed above driver patch the motivation "to optimize the CPU
> >>> overhead of the DIM worker caused by the guest being busy waiting for
> >>> the command response result."
> >>>
> >>> Is not right.
> >>> Because guest is still busy waiting.
> >> There is no busy wait for guests, see get_cvq_work().
> >>
> > Ok. not always busy waiting, sometimes it does.
>
> Busy waiting will only occur when the user command or dim command cannot
> find the available buffer for cvq.
>
> The user command is still in polling mode for now, I have not tried to
> optimize this. Now it's about improving dim performance.
>
> > virtnet_cvq_response() should not have flag..
>
> The flag is mainly used to identify whether it is a user command. If so,
> the previous polling mode will still be maintained.
>
> >
> > Who ever gets the OS global rtnl lock is calling virtnet_cvq_response()=
 and checking and releasing.
> > Shouldn=E2=80=99t be done this way with try lock etc.
> > Rtnl lock is not supposed to protect low level driver some ctrlvq respo=
nse flag.
>
> To summarize, we now want to make some improvements to cvq:
> 1. Reasonable timeout in busy waiting mode or interrupt-based etc.

Let's use interrupt to avoid tricky code.

> 2. Batch processing (the core problem is how to get results from user
> commands synchronously)
> 3. Remove rtnl_lock=E2=80=99s protection for ctrlq.

Virtio-comment is not the right place to discuss these. Let's move it to ne=
tdev.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

