Return-Path: <virtio-dev-return-13837-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E44ACD5BC6
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 14:10:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 845B11CA249
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 14:10:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32BAF986678
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 14:10:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1AC34986533; Tue, 19 Sep 2023 14:10:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08EEC986566
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 14:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wUHZsoF1Pb2POAqV46t-4w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132601; x=1695737401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyw2KeoOkZC1APyelXrFOmTZsa2l4yh/uDbdLnv/6jQ=;
        b=Flo5Lk3gRVRyjxmEQcXuJ5UviJRCSupBE9C08mwa52MuHX7v94DF1d3swyXn+15jCE
         H0xMpyT2ZaohIU4bW2Uu4aK5QZYUYm9zrdR+t1eBCFJ4Y/iSiA4okgwQgtEUuD0p+/p4
         YT8pfOLVLMuUtqcN0icmUJF0icvJ/cnBWDetc8wu0EuGEfp1+H9p/xZHIGpOMDkgEv99
         /YT1E/AljPZOLhszfMTnJB6F82eaV8jy1HY8eVWWllN4gcx6NEvHMkRYCA/+pCrVdxzW
         LqgRlMpu9e8I/tS3KrIPGndkEi6Z6jbhdH6OqwUE/c68HoktKNhkUpbH8aQ569d0hioY
         L9Ag==
X-Gm-Message-State: AOJu0YwdKhzNpJ1V6ngv9YW7AK8P5JE+52FkXU8ibALpfy+06mxzOe51
	/X3Ni1cvw0ggyAuB3qRHHga74hzwRVZICq1/e2NjDiZfYB/0xRqv7B8YTgQxZHPE2UvMj9eYlmX
	11Ec106jBYnpzxKYJUiSx11+OoEk+
X-Received: by 2002:a17:907:7623:b0:9a2:23cd:f052 with SMTP id jy3-20020a170907762300b009a223cdf052mr10399371ejc.7.1695132601306;
        Tue, 19 Sep 2023 07:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpgZEgdyo7v1yx6zWKgETwMn6YOu24MmBn1OYcVRXpT5tbMyU+8/PA2n74zv5NYGjCkSJwZw==
X-Received: by 2002:a17:907:7623:b0:9a2:23cd:f052 with SMTP id jy3-20020a170907762300b009a223cdf052mr10399352ejc.7.1695132600992;
        Tue, 19 Sep 2023 07:10:00 -0700 (PDT)
Date: Tue, 19 Sep 2023 10:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
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
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alex Deucher <Alexander.Deucher@amd.com>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
	Xenia Ragiadakou <burzalodowa@gmail.com>,
	Honglei Huang <Honglei1.Huang@amd.com>,
	Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Message-ID: <20230919100855-mutt-send-email-mst@kernel.org>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg

On Tue, Sep 19, 2023 at 12:10:29PM +0000, Parav Pandit wrote:
> Hi Jiqian,
> 
> > From: Jiqian Chen <Jiqian.Chen@amd.com>
> > Sent: Tuesday, September 19, 2023 5:13 PM
> > 
> > When guest vm does S3, Qemu will reset and clear some things of virtio
> > devices, but guest can't aware that, so that may cause some problems.
> It is not true that guest VM is not aware of it.
> As you show in your kernel patch, it is freeze/unfreeze in the guest VM PCI PM driver callback. So please update the commit log.
> 
> > For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> s/excample/example
> 
> > resume, that function will destroy render resources of virtio-gpu. As a result,
> > after guest resume, the display can't come back and we only saw a black
> > screen. Due to guest can't re-create all the resources, so we need to let Qemu
> > not to destroy them when S3.
> Above QEMU specific details to go in cover letter, instead of commit log, but no strong opinion.

i feel it does not matter much.

> Explaining the use case is good.
> 
> > 
> > For above purpose, we need a mechanism that allows guests and QEMU to
> > negotiate their reset behavior. So this patch add a new parameter named
> Freeze != reset. :)
> Please fix it to say freeze or suspend.
> 
> > freeze_mode to struct virtio_pci_common_cfg. And when guest suspends, it can
> > write freeze_mode to be FREEZE_S3, and then virtio devices can change their
> > reset behavior on Qemu side according to freeze_mode. What's more,
> Not reset, but suspend behavior.
> 
> > freeze_mode can be used for all virtio devices to affect the behavior of Qemu,
> > not just virtio gpu device.
> > 
> > Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> > ---
> >  transport-pci.tex | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/transport-pci.tex b/transport-pci.tex index a5c6719..2543536 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure
> > layout}\label{sec:Virtio Transport
> >          le64 queue_desc;                /* read-write */
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> > +        le16 freeze_mode;               /* read-write */
> >          le16 queue_notif_config_data;   /* read-only for driver */
> >          le16 queue_reset;               /* read-write */
> > 
> The new field cannot be in the middle of the structure.
> Otherwise, the location of the queue_notif_config_data depends on completely unrelated feature bit, breaking the backward compatibility.
> So please move it at the end.
> 
> > @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure
> > layout}\label{sec:Virtio Transport  \item[\field{queue_device}]
> >          The driver writes the physical address of Device Area here.  See section
> > \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> > 
> > +\item[\field{freeze_mode}]
> > +        The driver writes this to set the freeze mode of virtio pci.
> > +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> > +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-
> For above names, please define the actual values in the spec.
> 
> > pci enters S3 suspension;
> > +        Other values are reserved for future use, like S4, etc.
> > +
> It cannot be just one way communication from driver to device as freezing the device of few hundred MB to GB of gpu memory or other device memory can take several msec.
> Hence driver must poll to get the acknowledgement from the device that freeze functionality is completed.
> 
> Please refer to queue_reset register definition for achieving such scheme and reframe the wording for it.
> 
> Also kindly add the device and driver normative on how/when this register is accessed.
> 
> Also please fix the description to not talk about guest VM. Largely it only exists in theory of operation etc text.
> 
> You need to describe what exactly should happen in the device when its freeze.
> Please refer to my series where infrastructure is added for device migration where the FREEZE mode behavior is defined.
> It is similar to what you define, but its management plane operation controlled outside of the guest VM.
> But it is good direction in terms of what to define in spec language.
> https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#u
> 
> you are missing the feature bit to indicate to the driver that device supports this functionality.
> Please add one.
> 
> >  \item[\field{queue_notif_config_data}]
> >          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been
> > negotiated.
> >          The driver will use this value when driver sends available buffer
> > --
> > 2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

