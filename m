Return-Path: <virtio-dev-return-12578-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E45C7EE2C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:22:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 18E676004A
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:22:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0F5F9866BE
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 15:22:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C8C5D98665E; Fri,  5 May 2023 15:22:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B51139866B6
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 15:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PUtUVbPzNp6vofHRD_H4XQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683300126; x=1685892126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAmQUyaw0e0OsDLYKrGkTQiU1YXzFWlsnZxPSh36UcM=;
        b=dyFTSJTrjJzE8Q/DK8G2Nqg/GY0K6U1sYmTXIVHyG9IPelFs1Ywxoyn2NYSKR7AC+R
         iYSUUxX6z6ZzAP45OcNWQOXieoBtI3ULpR8fMaBO1UqRHGY1g8ZamafhyIHtgUUVI44H
         E/SDpyTtd0c8U4gLQc3FuhjwKtJZ4SQMUNlI0fa3l0/OoygBz1T+TdMVN4NGSIBLiTiO
         k4eSda8fVvj+PE/9gFZss10pBlko5f7neWIO+gAwC7ld2Qd99Kq4UdazC+BwG78G3ik4
         vBuDYRCwq/vZPVYFQ0Oe+5ZH9bzx/sGpuxft/QXoMy7hudhEG9qzl7aSVMaFB9bk5NIS
         lU8Q==
X-Gm-Message-State: AC+VfDy6D6yevekw9ADexIwMPG6S3BvWgirc0PGP5nz369JgWbVggxCj
	fXPYOlPGUz19HbfBbvBZ4L3ffjc1mJroyzsXbrrZvN2CDAUMUk7lUsEr9o10G3YbQwGW2a/rmtQ
	Uf1yYBS2KMxfUXuDeEuBn2mbvi2y/
X-Received: by 2002:a17:907:9482:b0:962:9ffa:be1a with SMTP id dm2-20020a170907948200b009629ffabe1amr1600295ejc.36.1683300126515;
        Fri, 05 May 2023 08:22:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5E3Wu6j74SFp+/4ABD3JVVm5vCellKxdxRLQcp+02vj8lr8lSsz1rQ7WcLiJsMmmh0uZaOSQ==
X-Received: by 2002:a17:907:9482:b0:962:9ffa:be1a with SMTP id dm2-20020a170907948200b009629ffabe1amr1600281ejc.36.1683300126218;
        Fri, 05 May 2023 08:22:06 -0700 (PDT)
Date: Fri, 5 May 2023 11:22:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230505112108-mutt-send-email-mst@kernel.org>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
 <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
 <a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com>
 <5cb79b37-a066-283c-eee7-afd26146d988@nvidia.com>
 <PH0PR12MB5481B60350D145531A43E567DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B60350D145531A43E567DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci

On Wed, Apr 26, 2023 at 10:11:53PM +0000, Parav Pandit wrote:
> 
> > From: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Sent: Wednesday, April 26, 2023 5:12 PM
> > 
> > On 25/04/2023 1:14, Parav Pandit wrote:
> > >
> > >
> > > On 4/24/2023 6:06 PM, Max Gurtovoy wrote:
> > >
> > >>> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> > >>> +configures any administration virtqueues, the driver MUST configure
> > >>> +the administration virtqueues using the index in the range
> > >>> +\field{admin_queue_index} to \field{admin_queue_index} +
> > >>> +\field{admin_queue_num} - 1 inclusive.
> > >>> +The driver MAY configure less administration virtqueues than
> > >>> +supported by the device.
> > >>
> > >> we need to say something about other virtq's indexes.
> > >> For example, if aq index = 0 then for the vblk device the request
> > >> queues would start from index = 1.
> > >>
> > >> can we address this ?
> > >
> > > It may slightly complicate the device implementation when device
> > > dynamically changes the VQ indices based on the negotiation of the
> > > feature bit.
> > > Also the drivers with and without need a different VQ index handling.
> > >
> > > I am thinking that aq index should not overlap with the vq index in
> > > range exposed by num_queues field.
> > >
> > > This also aligns to the exclusion of aq count from num_queues field.
> > 
> > The namespace of the aq and other vq index is the same.
> > And the configuration is done using the same queue_select and other registers.
> > Thus, we need to address the above comment otherwise all the device
> > virtqueues chapters are wrong.
> 
> Michael has added below line in this patch in num_queues description so it covers the exclusion part.
> 
> +        This excludes administration virtqueues if any are supported.
> 
> I inspected all the devices.
> Following devices which has multi queue supports are fine, net, console, scsi host, gpu, input, crypto, socket, rpmb, iommu, sound, scmi, gpio. 
> 
> Following single q devices are fine too: entropy, mem ballon dev, mem, i2c, pmem.
> So mostly all chapters don’t look wrong.
> 
> Block device needs below change.
> WDYT?
> 
> From 0592d167451280bc212df7322077f4c94b28c917 Mon Sep 17 00:00:00 2001
> From: Parav Pandit <parav@nvidia.com>
> Date: Thu, 27 Apr 2023 01:01:41 +0300
> Subject: [PATCH] virtio-blk: Rename num_queues to num_req_queues
> 
> num_queues field represents number of blk specific request queues.
> 
> Renaming it to num_req_queues reflect its precise usage.
> It also avoids confusion with PCI transport's generic num_queues field.

There's no confusion actually - both fields are exactly the same
are they not? The one in blk just predates the one in pci.

> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  device-types/blk/description.tex | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
> index f04c932..5a27399 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -16,7 +16,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
>  \end{description}
> 
>   N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
> - \field{num_queues}.
> + \field{num_req_queues}.
> 
>  \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
> 
> @@ -108,7 +108,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>          } topology;
>          u8 writeback;
>          u8 unused0;
> -        u16 num_queues;
> +        u16 num_req_queues;
>          le32 max_discard_sectors;
>          le32 max_discard_seg;
>          le32 discard_sector_alignment;
> @@ -135,8 +135,8 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
>  present. The availability of the others all depend on various feature
>  bits as indicated above.
> 
> -The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
> -the number of queues.
> +The field \field{num_req_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
> +the number of request queues.
> 
>  The parameters in the configuration space of the device \field{max_discard_sectors}
>  \field{discard_sector_alignment} are expressed in 512-byte units if the
> --
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

