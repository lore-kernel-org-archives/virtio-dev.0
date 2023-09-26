Return-Path: <virtio-dev-return-13967-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A0EE7E62C
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:58:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EB6F61CA25A
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:58:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2D009864A3
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:58:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D3F2B98639D; Tue, 26 Sep 2023 11:58:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFE119863A6
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 11:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2wKdvPOyNRahlsqCZq51cg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695729477; x=1696334277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDUQkJqKg7a5pju4oZMwjxktm9UZqgOLon6vQViMVus=;
        b=R4XPXdN4KXRvZwFJD2F3WAOqiW80UtAQ7K/6q3dTn3S/P7JEBUtFnR0znAopEeShLe
         Jiavv1YfrA/sUPKzRN7F4Be4d1FEyEgYK55PwkQetz6H/hlu/ym/K4EsQQV9nkkmrzBs
         Evvh3i8gnDQTd0xtBL9uAaUVtgSLOUg8YyfQQBc+rnfctUWbnPveN3Ik8ic42mX9J/0M
         YOoB4Vk0CcoV/WTPCnG5TLHCsWu4qLVQj0NMP3W28JXZexuYwcXZxuDyUQq4Q2AeUQ8n
         JLBaEBaBtS64PrI/UiDRtkYwi1/Qt6B6UaEnJcot/9Rqaf/MjzmKJEB0wLWk5AwC6l6B
         TDZQ==
X-Gm-Message-State: AOJu0YzNyR72de2mSVc15q6LzX4ddDJRR+eTM79M5m+AhqLJ/NtzlsUR
	CTM4eaJvunh5GQKP/3rPQSc4hpT6qF9clclEOJfjZiJtOBFVgQD0bm5PGxytpr0H1PvmB+Via2y
	nvFmjCIwPZbIIvVl/8YGgh/Xjn4os
X-Received: by 2002:a05:6000:1819:b0:31f:db58:993e with SMTP id m25-20020a056000181900b0031fdb58993emr8650890wrh.66.1695729476960;
        Tue, 26 Sep 2023 04:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqUu5eJTqHbuMDPnmmu6KVVJT0sBWxlgD7fJH5FsjF8TPqDhT5qOa8OpOO9UR50WMQw5yd9Q==
X-Received: by 2002:a05:6000:1819:b0:31f:db58:993e with SMTP id m25-20020a056000181900b0031fdb58993emr8650871wrh.66.1695729476535;
        Tue, 26 Sep 2023 04:57:56 -0700 (PDT)
Date: Tue, 26 Sep 2023 07:57:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>, Jason Wang <jasowang@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
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
Message-ID: <20230926075503-mutt-send-email-mst@kernel.org>
References: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
 <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
 <BL1PR12MB5849B427B23D1ED269808463E7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtuRwAig_AbMA1YFa9YVw2aBQJDhZ06ZiD_QugthPDROQ@mail.gmail.com>
 <BL1PR12MB584991A9503502EDCB6B9D0BE7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481E765DA98E7AD3D1BED15DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E765DA98E7AD3D1BED15DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

On Tue, Sep 26, 2023 at 11:37:37AM +0000, Parav Pandit wrote:
> Hi Jiqian,
> 
> > From: Chen, Jiqian <Jiqian.Chen@amd.com>
> > Sent: Tuesday, September 26, 2023 4:30 PM
> 
> > It is not to trigger resume behavior to device by setting unfreeze in my scenario.
> > You may misunderstand my intention.
> > In current kernel and qemu code, it will trigger reset device behavior by setting
> > device_status to 0 during resuming, and I found some operations of reset is not
> > reasonable during resuming, like virtio_gpu_reset, it will destroy render
> > resources and then caused the display gone after guest finishing reusming.
> 
> When suspend is done, resume must not be done.
> I don’t see a need to mix these operations from guest specially when suspend is done.
> 
> Did I miss your response for my suggestion few days ago in [1] for not mixing reset with suspend?
> 
> When new feature bit of suspend is offered, guest will _not_ do reset, hence no need to mix reset with suspend.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00260.html

I frankly don't understand what you proposed there.

reset is a simple operation, it just erases all virtio
state from the device. It is very commonly is performed at
OS/driver startup. Making it not reset some virtio state
is a bad idea since suddenly you kexec a guest
that attempts a reset and device is stuck in some weird state.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

