Return-Path: <virtio-dev-return-12740-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0307CC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:48:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 49D4F120D6E
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:48:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FA299865B7
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:48:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 31BEA9862F6; Tue, 16 May 2023 21:48:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CF879862F7
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 21:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oMRRYfq5P6mIqTxIExN-hQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684273717; x=1686865717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IBceOoHgbWYBHjo4XPwVFLGydz3wNHXWfBOstHhHms=;
        b=XcPUS99HCIIj4E3qwTAkH/weXHrhJs126asOqOGbbWoCJM5IyhHlI3Kzg4uU83LCf9
         3AqELGNgNkjYf7m5iJ1ksB0VketvcyRVvRgUEYurd4TtLt4rGU92A33dfD3hYMzaC3Ze
         AGrPasblW3IQfcDW2E9HnTGds2OugmCw/YBcFvZt5AIwS4sAW7AhuNUPfqZs1ezkgV7A
         UKr3BmADmFaLXq4hlqlmwV1hjFkW/emVp0EpsdUcY0OKItRfg+74jOtW0CwSGCw7KzRW
         hzAyAngTZnB7iKVo8y+R1pOrfyp8WLOxqDq/cZTIHYbhNHzev4ipw2P1OlVU1UtB0si9
         YoSA==
X-Gm-Message-State: AC+VfDwoVkMQi5zzxLFaOGIBvqKkEE5dBCLUvEc4oJ3wyK/RdY4l9Dee
	Jrbeg/yBGbP7aWibCBKrMttkTWo6ptSw+m2sk0ajqY2vpKHXlXddZVSJ2cmsVkFvB9AF1WwCr3I
	UJ45jpt1ZdpnejdADfvfkQO6l8vuf
X-Received: by 2002:a7b:ca45:0:b0:3f4:22da:c3f1 with SMTP id m5-20020a7bca45000000b003f422dac3f1mr21634858wml.17.1684273717412;
        Tue, 16 May 2023 14:48:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Z7tmQHyxfB9kuriFACK2M8cWSvlu5xu8kmJr5euepiHBKrrzh1mNPwmFjDC0c+wDLywVCmA==
X-Received: by 2002:a7b:ca45:0:b0:3f4:22da:c3f1 with SMTP id m5-20020a7bca45000000b003f422dac3f1mr21634851wml.17.1684273717107;
        Tue, 16 May 2023 14:48:37 -0700 (PDT)
Date: Tue, 16 May 2023 17:48:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516174558-mutt-send-email-mst@kernel.org>
References: <20230516030139.767838-1-parav@nvidia.com>
 <20230516013842-mutt-send-email-mst@kernel.org>
 <87lehohefn.fsf@redhat.com>
 <20230516054313-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481451FE5B75AEA9864C0E1DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516164254-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548155D503296E253EEA0395DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516172348-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810B88AD58B00B329D3466DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810B88AD58B00B329D3466DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] content: Replace guest OS with driver

On Tue, May 16, 2023 at 09:31:43PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 16, 2023 5:25 PM
> 
> > > Flavor of a RHEL has inbuilt.
> > 
> > What does this mean exactly? That virtio core is compiled into kernel?
> > That does not matter at all.
> > 
> Why does it does not matter? What is the definition of driver, is the device_structure structure or module binary?

Neither. It's the part that handles transport or specific device.




> > > > > Does driver only matter with device_driver structure or module binary?...
> > > >
> > > > Can't parse your question.
> > > >
> > > > > Driver is largely the software entity that drives the device.
> > > > > I think we can keep the spec simple enough to not mix these
> > > > > details and just
> > > > call it a "driver".
> > > >
> > > > Not just linux there are lots of drivers like this.  the two bits
> > > > pass useful information the way you changed it this distinction is lots.
> > > > I agree it is worth thinking what exactly does it mean.
> > > > Since you researched it - what exactly do drivers such as uefi and
> > > > the unnamed "some OS variant" do exactly?
> > > There is just one "driver" virtio_net_pci that has sets the required bits.
> > >
> > > > when do they set ACKNOWLEDGE and when DRIVER?
> > > >
> > > Not any different flow.
> > > Entity is one.
> > 
> > question is, what happens
> > - before ACKNOWLEDGE
> > - after ACKNOWLEDGE before DRIVER
> > ?
> It follows the same sequence described in the spec as "driver" not as "guest OS".


Looks like my description is spot on then - check vendor ID,
set ACKNOWLEDGE, check device ID, see that it's a known good value
matching device type we expect, set DRIVER.

Maybe replace with "transport part of the driver" and
"device type specific part of the driver"? A bit verbose but if
it rocks your boat ...

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

