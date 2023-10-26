Return-Path: <virtio-dev-return-14025-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940C3C25B48
	for <virtio-dev@archiver.kernel.org>; Thu, 26 Oct 2023 10:30:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F005626A3C
	for <virtio-dev@archiver.kernel.org>; Thu, 26 Oct 2023 10:30:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4AA4986A67
	for <virtio-dev@archiver.kernel.org>; Thu, 26 Oct 2023 10:30:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D85DD986A5B; Thu, 26 Oct 2023 10:30:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA3DC986A5C
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Oct 2023 10:30:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: z1h9GcGYPKWkL3HKhjXg-A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698316218; x=1698921018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1Ef3ii2gm4KqPWZcAhV4s7glXjQCBPhEei8z0YCtAk=;
        b=im6E9YxQ0MTlNk5O8o7LyfT7wg0gQrrusciyUEU52ocrV96Zla563Hzc7N7zXBLczG
         m24rIPNeUGTQuFTQzAKkQYN60xwMZdK5ZUvXWmxBS6dxRn55lsud6K4PLZyD3iYR4Bcp
         uDVt16VM/9YTjM1SAQ5FC0CJ6fFbX9p7lLM4+e5lXivOMuOkXXiL5MX6a68Md8vJVMRg
         HwD5M7G3T7sEEw3/BziRifwvYBZ+b61prdEtaIyFESI8j2o07n6YY0SiaSZjqc21imHt
         gX7ZXAW+YFoPtgojE2JFuYqTGu4f2Lofe16nJrAw2iT8iyJ4PUcKDLZdfu/eWXA9HHEV
         PZnA==
X-Gm-Message-State: AOJu0YxeepTiAzXAbGMkP2X4FX0iJjUFbjYQKZ0KjAkvRSpp/hX49PqG
	UyOp7X8A36RBg9K/ZLhbELOHj/nLWN6oIOJfvdrTuIZ8S10nKcn+nx4V/B2mTXkZk5l5nuNWYhu
	D8eIqoIYM+0z2ts+PXc1WU5vf/ORR
X-Received: by 2002:a17:907:6092:b0:9be:dce3:6e07 with SMTP id ht18-20020a170907609200b009bedce36e07mr15243743ejc.32.1698316217811;
        Thu, 26 Oct 2023 03:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESKo7fEYXgx0/Io/4gPse4J//QvwRwqXD1thh29SMJN5hALXi88k5kyor0c21vM88dEDfRHg==
X-Received: by 2002:a17:907:6092:b0:9be:dce3:6e07 with SMTP id ht18-20020a170907609200b009bedce36e07mr15243719ejc.32.1698316217412;
        Thu, 26 Oct 2023 03:30:17 -0700 (PDT)
Date: Thu, 26 Oct 2023 06:30:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Parav Pandit <parav@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>,
	"Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Message-ID: <20231026062805-mutt-send-email-mst@kernel.org>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

On Thu, Oct 26, 2023 at 10:24:26AM +0000, Chen, Jiqian wrote:
> 
> On 2023/10/25 11:51, Parav Pandit wrote:
> > 
> > 
> >> From: Chen, Jiqian <Jiqian.Chen@amd.com>
> >> Sent: Tuesday, October 24, 2023 5:44 PM
> >>
> >> On 2023/10/24 18:51, Parav Pandit wrote:
> >>>
> >>>> From: Chen, Jiqian <Jiqian.Chen@amd.com>
> >>>> Sent: Tuesday, October 24, 2023 4:06 PM
> >>>>
> >>>> On 2023/10/23 21:35, Parav Pandit wrote:
> >>>>>
> >>>>>> From: Chen, Jiqian <Jiqian.Chen@amd.com>
> >>>>>> Sent: Monday, October 23, 2023 4:09 PM
> >>>>>
> >>>>>>> I think this can be done without introducing the new register.
> >>>>>>> Can you please check if the PM register itself can serve the
> >>>>>>> purpose instead
> >>>>>> of new virtio level register?
> >>>>>> Do you mean the system PM register?
> >>>>> No, the device's PM register at transport level.
> >>>> I tried to find this register(pci level or virtio pci level or virtio
> >>>> driver level), but I didn't find it in Linux kernel or Qemu codes.
> >>>> May I know which register you are referring to specifically? Or which
> >>>> PM state bit you mentioned below?
> >>>>
> >>> PCI spec's PCI Power Management Capability Structure in section 7.5.2.
> >> Yes, what you point to is PM capability for PCIe device.
> >> But the problem is still that in Qemu code, it will check the
> >> condition(pci_bus_is_express or pci_is_express) of all virtio-pci devices in
> >> function virtio_pci_realize(), if the virtio devices aren't a PCIe device, it will not
> >> add PM capability for them.
> > PCI PM capability is must for PCIe devices. So may be QEMU code has put it only under is_pcie check.
> > But it can be done outside of that check as well because this capability exists on PCI too for long time and it is backward compatible.
> Do you suggest me to implement PM capability for virtio devices in
> Qemu firstly, and then to try if the PM capability can work for this
> scenario?

virtio devices in qemu already have a PM capability.


> If so, we will complicate a simple problem. Because there are no other needs to add PM capability for virtio devices for now, if we add it just for preserving resources, it seems unnecessary and unreasonable. And we are not sure if there are other scenarios that are not during the process of PM state changing also need to preserve resources, if have, then the PM register can't cover, but preserve_resources register can.

One of the selling points of virtio is precisely reusing existing
platform capabilities as opposed to coming up with our own.
See abstract.tex


> Can I add some notes like "If PM capability is implemented for virtio devices, it may cover this scenario, and if there are no other scenarios that PM can't cover, then we can remove this register " in commit message or spec description and let us continue to add preserve_resources register?

We can't remove registers.

> > 
> >> And another problem is how about the MMIO transport devices? Since
> >> preserve resources is need for all transport type devices.
> >>
> > MMIO lacks such rich PM definitions. If in future MMIO wants to support, it will be extended to match to other transports like PCI.
> > 
> >>>>>
> >>>>>> I think it is unreasonable to let virtio- device listen the PM
> >>>>>> state of Guest system.
> >>>>> Guest driver performs any work on the guest systems PM callback
> >>>>> events in
> >>>> the virtio driver.
> >>>> I didn't find any PM state callback in the virtio driver.
> >>>>
> >>> There are virtio_suspend and virtio_resume in case of Linux.
> >> I think what you said virtio_suspend/resume is freeze/restore callback from
> >> "struct virtio_driver" or suspend/resume callback from "static const struct
> >> dev_pm_ops virtio_pci_pm_ops".
> >> And yes, I agree, if virtio devices have PM capability, maybe we can set PM state
> >> in those callback functions.
> >>
> >>>
> >>>>>
> >>>>>> It's more suitable that each device gets notifications from driver,
> >>>>>> and then do preserving resources operation.
> >>>>> I agree that each device gets the notification from driver.
> >>>>> The question is, should it be virtio driver, or existing pci driver
> >>>>> which
> >>>> transitions the state from d0->d3 and d3->d0 is enough.
> >>>> It seems there isn't existing pci driver to transitions d0 or d3
> >>>> state. Could you please tell me which one it is specifically? I am very willing to
> >> give a try.
> >>>>
> >>> Virtio-pci modern driver of Linux should be able to.
> >> Yes, I know, it is the VIRTIO_PCI_FLAG_INIT_PM_BIT. But still the two problems I
> >> said above.
> >>
> > Both can be resolved without switching to pcie.
> >  
> >>>
> >>>>> Can you please check that?
> >>>>>
> >>>>>>>> --- a/transport-pci.tex
> >>>>>>>> +++ b/transport-pci.tex
> >>>>>>>> @@ -325,6 +325,7 @@ \subsubsection{Common configuration
> >> structure
> >>>>>>>> layout}\label{sec:Virtio Transport
> >>>>>>>>          /* About the administration virtqueue. */
> >>>>>>>>          le16 admin_queue_index;         /* read-only for driver */
> >>>>>>>>          le16 admin_queue_num;         /* read-only for driver */
> >>>>>>>> +        le16 preserve_resources;        /* read-write */
> >>>>>>> Preserving these resources in the device implementation takes
> >>>>>>> finite amount
> >>>>>> of time.
> >>>>>>> Possibly more than 40nsec (time of PCIe write TLP).
> >>>>>>> Hence this register must be a polling register to indicate that
> >>>>>> preservation_done.
> >>>>>>> This will tell the guest when the preservation is done, and when
> >>>>>>> restoration is
> >>>>>> done, so that it can resume upper layers.
> >>>>>>>
> >>>>>>> Please refer to queue_reset definition to learn more about such
> >>>>>>> register
> >>>>>> definition.
> >>>>>> Thanks, I will refer to "queue_reset". So, I need three values,
> >>>>>> driver write 1 to let device do preserving resources, driver write
> >>>>>> 2 to let device do restoring resources, device write 0 to tell
> >>>>>> driver that preserving or restoring done, am I right?
> >>>>>>
> >>>>> Right.
> >>>>>
> >>>>> And if the existing pcie pm state bits can do, we can leverage that.
> >>>>> If it cannot be used, lets add that reasoning in the commit log to
> >>>>> describe this
> >>>> register.
> >>>>>
> >>>>>>>
> >>>>>>> Lets please make sure that PCIe PM level registers are
> >>>>>>> sufficient/not-sufficient
> >>>>>> to decide the addition of this register.
> >>>>>> But if the device is not a PCIe device, it doesn't have PM
> >>>>>> capability, then this will not work. Actually in my local
> >>>>>> environment, pci_is_express() return false in Qemu, they are not
> >>>>>> PCIe
> >>>> device.
> >>>>> It is reasonable to ask to plug in as PCIe device in 2023 to get new
> >>>>> functionality that too you mentioned a gpu device. 😊
> >>>>> Which does not have very long history of any backward compatibility.
> >>>> Do you suggest me to add PM capability for virtio-gpu or change
> >>>> virtio-gpu to a PCIe device?
> >>>>
> >>> PCI Power Management Capability Structure does not seem to be limited to
> >> PCIe.
> >> I am not sure, but in current Qemu code, I can see the check "pci_is_express"
> >> for all virtio-pci devices. If we want to add PM capability for virtio-pci devices,
> >> we need to change them to PCIe device I think.
> >>
> > That is one option.
> > Second option to extend PCI PM cap for non pci device because it is supported.
> > 
> >>>
> >>
> >> --
> >> Best regards,
> >> Jiqian Chen.
> 
> -- 
> Best regards,
> Jiqian Chen.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

