Return-Path: <virtio-dev-return-13965-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC9E8181A
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:10:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5DDC7613D0
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:10:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C99598640F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:10:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F2187983DE3; Tue, 26 Sep 2023 11:10:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0D779863A6
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 11:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rdnEB6SbPPOFez3MWOGPoQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695726601; x=1696331401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnrmGk4QtxhaviiGGfsef9huaLtyb7sOtQzWzk0b+Rs=;
        b=MXEd5opC3jUyIfCaSiTZ03xfoB2/+1OBj3dxadi++x13IS+wlI2Bmzt59Mx4NdEXaB
         Pqw8Qb3/k/YePS9L6bnCp8s9w35hxXWe5JJlQaSgkGJPTSsXgQ61E3ff8n9ZA2qEMrYG
         Dh++EMn5tj2CVBORIA+MmWNN+M8g/73beNhNddjdMyBAUMsgreFrwysJT5ICfDk2wBpv
         KCg4FEIkJajldZbQeFteV2/ZeKiyj74T7I9X6h0d0gXoF4RXH8qbhvzwsX0bnlPzZv2J
         II+O/VAtl7Ht19CrEPi1zjifIIgtsI4oSlX/9PUbOs6fdXDIEnQlcVcOtbk6dwSfJ1Ls
         Xmnw==
X-Gm-Message-State: AOJu0Yy4fxJv3cEzUE60N9KZ7+6oTWc6fvIA8CAxm/7ZEVgdjIxvUTvV
	5OVYyV9schwyf2D+Y1WOXET+Y1mBV2NRptu7Wc2rpeu68FWIAGE1K3mM3HeLVtP0+A/h3EdzKTz
	dN2xDI6H4DlV2YJiLDXBU6Mx4xVEB
X-Received: by 2002:aa7:d346:0:b0:530:bad5:248e with SMTP id m6-20020aa7d346000000b00530bad5248emr8396009edr.3.1695726601723;
        Tue, 26 Sep 2023 04:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgobkd6nfpg2l6hh64ZNhfWCPxSEi7BUl98RfI/bDJuC8ClsVV5zh89YmiCp482bATCeMLOA==
X-Received: by 2002:aa7:d346:0:b0:530:bad5:248e with SMTP id m6-20020aa7d346000000b00530bad5248emr8395977edr.3.1695726601335;
        Tue, 26 Sep 2023 04:10:01 -0700 (PDT)
Date: Tue, 26 Sep 2023 07:09:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
	Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>,
	"Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Message-ID: <20230926070329-mutt-send-email-mst@kernel.org>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
 <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
 <BL1PR12MB5849B427B23D1ED269808463E7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtuRwAig_AbMA1YFa9YVw2aBQJDhZ06ZiD_QugthPDROQ@mail.gmail.com>
 <BL1PR12MB584991A9503502EDCB6B9D0BE7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BL1PR12MB584991A9503502EDCB6B9D0BE7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

On Tue, Sep 26, 2023 at 11:00:28AM +0000, Chen, Jiqian wrote:
> On 2023/9/26 10:51, Jason Wang wrote:
> > On Tue, Sep 26, 2023 at 10:24 AM Chen, Jiqian <Jiqian.Chen@amd.com> wrote:
> >>
> >> On 2023/9/25 10:52, Jason Wang wrote:
> >>> On Fri, Sep 22, 2023 at 4:07 PM Chen, Jiqian <Jiqian.Chen@amd.com> wrote:
> >>>>
> >>>> Hi Jason,
> >>>>
> >>>> On 2023/9/22 11:17, Jason Wang wrote:
> >>>>> On Thu, Sep 21, 2023 at 2:28 PM Chen, Jiqian <Jiqian.Chen@amd.com> wrote:
> >>>>>>
> >>>>>> Hi Jason,
> >>>>>>
> >>>>>> On 2023/9/21 12:22, Jason Wang wrote:
> >>>>>>> On Tue, Sep 19, 2023 at 7:43 PM Jiqian Chen <Jiqian.Chen@amd.com> wrote:
> >>>>>>>>
> >>>>>>>> When guest vm does S3, Qemu will reset and clear some things of virtio
> >>>>>>>> devices, but guest can't aware that, so that may cause some problems.
> >>>>>>>> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> >>>>>>>> resume, that function will destroy render resources of virtio-gpu. As
> >>>>>>>> a result, after guest resume, the display can't come back and we only
> >>>>>>>> saw a black screen. Due to guest can't re-create all the resources, so
> >>>>>>>> we need to let Qemu not to destroy them when S3.
> >>>>>>>>
> >>>>>>>> For above purpose, we need a mechanism that allows guests and QEMU to
> >>>>>>>> negotiate their reset behavior. So this patch add a new parameter
> >>>>>>>> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> >>>>>>>> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> >>>>>>>> devices can change their reset behavior on Qemu side according to
> >>>>>>>> freeze_mode. What's more, freeze_mode can be used for all virtio
> >>>>>>>> devices to affect the behavior of Qemu, not just virtio gpu device.
> >>>>>>>
> >>>>>>> A simple question, why is this issue specific to pci?
> >>>>>> I thought you possibly missed the previous version patches. At the beginning, I just wanted to add a new feature flag VIRTIO_GPU_F_FREEZE_S3 for virtio-gpu since I encountered virtio-gpu issue during guest S3, so that the guest and qemu can negotiate and change the reset behavior during S3. But Parav and Mikhail hoped me can improve the feature to a pci level, then other virtio devices can also benefit from it. Although I am not sure if expanding its influence is appropriate, I have not received any feedback from others, so I change it to the pci level and made this version.
> >>>>>> If you are interested, please see the previous version: https://lists.oasis-open.org/archives/virtio-comment/202307/msg00209.html, thank you.
> >>>>>
> >>>>> This is not a good answer. Let me ask you differently, why don't you
> >>>>> see it in other forms of transport like virtio-gpu-mmio?
> >>>> Sorry for not understanding your question before. Did you mean why did I add freeze_mode for virtio-pci type devices instead of virtio-mmio type devices?
> >>>
> >>> Yes.
> >>>
> >>>> If that's the case, it isn't well thought out by me, because there is only virtio-gpu with pci support in my environment, so I, as a matter of course, improve it from virtio-gpu-pci to a virtio-pci level instead of virtio-mmio.
> >>>> Do you think I need to add freeze_mode for virtio-mmio too?
> >>>
> >>> Because the function you describe is to preserve the render resources
> >>> which have nothing specific to PCI. It's a core virtio function.
> >>>
> >>> I'd suggest fixing it at the virtio level instead of PCI level.
> >> Yes, you are right, I will change to describe it to the virtio level in next version.
> >>
> >>>
> >>>> Or improve it to a higher level, like virtio-bus? I am looking forward to getting your suggestions, thanks.
> >>>
> >>> As pointed out in other thread, reusing the existing status state
> >>> machine is a perfect way for doing this.
> >>>
> >>> We can tweak the state machine to be able to do both migration and S3.
> >> I noticed the other thread you said, it will add a SUSPEND status to into device_status field, but it seems not enough to meet all scenarios, like we need to set the unfreeze state of guest,
> > 
> > It's just a resume by clearing the suspend bit?
> It is not to trigger resume behavior to device by setting unfreeze in my scenario.
> You may misunderstand my intention.
> In current kernel and qemu code, it will trigger reset device behavior by setting device_status to 0 during resuming, and I found some operations of reset is not reasonable during resuming, like virtio_gpu_reset, it will destroy render resources and then caused the display gone after guest finishing reusming.
> So, I will set guest to S3 when suspending, and then qemu will notice the S3 state of guest, and then it will not destroy render resources for virtio-gpu during resuming. The unfreeze state will be set after guest completed resuming.
> I think other virtio devices can also change the unreasonable behavior of resetting during resuming according the S3 state. And this will not affect other reset situation, just reset during resuming.
> I think this patch doesn't conflict with the patch in another thread, and they have different roles.
> Perhaps I need to use different words to avoid misunderstandings, not freeze or suspend, maybe state_s3, state_normal etc.


And then I have to ask - aren't any of the standard power states
appropriate here? I am not a PM expert but I think that it's unusual to
have device get the system state as opposed to device power state. No?


> > 
> >>
> > 
> >> the S3 state of the guest, the S4 state of the guest etc.
> > 
> > Hibernation is different from suspending, it probably requires
> > setting/getting device states. And I don't get how this patch can help
> > with hibernation.
> The same reason as above, guest can set it to S4 state, and then we can change some behaviors on qemu side, so that to help guest resume from hibernation better.
> 
> > 
> >> So, one bit is not enough to indicate what status the guest is, since the freeze mode is a series,
> > 
> > We can tweak the existing status state machine, otherwise you need to
> > explain the interaction between the two. For example what happens if
> > we freeze after reset etc.
> > 
> > And if you do that, it is actually a single state machine.
> > 
> > Thanks
> > 
> >> I think add a new field to describe it is more reasonable.
> >>
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >>>>>>>> ---
> >>>>>>>>  transport-pci.tex | 7 +++++++
> >>>>>>>>  1 file changed, 7 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/transport-pci.tex b/transport-pci.tex
> >>>>>>>> index a5c6719..2543536 100644
> >>>>>>>> --- a/transport-pci.tex
> >>>>>>>> +++ b/transport-pci.tex
> >>>>>>>> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >>>>>>>>          le64 queue_desc;                /* read-write */
> >>>>>>>>          le64 queue_driver;              /* read-write */
> >>>>>>>>          le64 queue_device;              /* read-write */
> >>>>>>>> +        le16 freeze_mode;               /* read-write */
> >>>>>>>>          le16 queue_notif_config_data;   /* read-only for driver */
> >>>>>>>>          le16 queue_reset;               /* read-write */
> >>>>>>>>
> >>>>>>>> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> >>>>>>>>  \item[\field{queue_device}]
> >>>>>>>>          The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> >>>>>>>>
> >>>>>>>> +\item[\field{freeze_mode}]
> >>>>>>>> +        The driver writes this to set the freeze mode of virtio pci.
> >>>>>>>> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> >>>>>>>> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
> >>>>>>>> +        Other values are reserved for future use, like S4, etc.
> >>>>>>>> +
> >>>>>>>>  \item[\field{queue_notif_config_data}]
> >>>>>>>>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
> >>>>>>>>          The driver will use this value when driver sends available buffer
> >>>>>>>> --
> >>>>>>>> 2.34.1
> >>>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> ---------------------------------------------------------------------
> >>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >>>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >>>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Best regards,
> >>>>>> Jiqian Chen.
> >>>>>
> >>>>
> >>>> --
> >>>> Best regards,
> >>>> Jiqian Chen.
> >>>
> >>>
> >>> ---------------------------------------------------------------------
> >>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >>>
> >>
> >> --
> >> Best regards,
> >> Jiqian Chen.
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> 
> -- 
> Best regards,
> Jiqian Chen.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

