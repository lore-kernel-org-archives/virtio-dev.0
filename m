Return-Path: <virtio-dev-return-12736-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF671C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:25:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0BF2B1CA24E
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:25:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3D729865B2
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 21:25:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E78099862F6; Tue, 16 May 2023 21:25:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D77689862F7
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 21:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: pCo2XeeUN9GR2gA7ypOzug-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272330; x=1686864330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33wzW51sKMz8o+kGUjlfX6LqS4cnngHC//3vy58o86o=;
        b=GXY5mgyDszMyuWGxoDcb6xx6XT8SGAqaZXurpWqu8UK+ZeU3eGHg3VVmqwpXBBL1A+
         F8eqNGj8PbeKkI1CKrDBDB5a+4EkpA/5FYc9guPgHm3LQNcUrANeRvizxYYtlWFKa+6R
         r6WkT9zpy7+Sid2oB6PfgcaqMPEHB8x19pO5cBepQCftHLBwN3pAXZaNfNfSPg2l+F0Y
         /R4DpD5ssUUQsa97Gt6HUMkfkuS7vWjPgvI9k5hv2wbwVb7smhcVKeEqkJP6LrsX+A5x
         e79liUI/50ySowQ24mAIug7hCIfHBmIfpLsL+sYw4tuUsh+k/3KhRhRdGHI9YQpRPeeX
         9MMQ==
X-Gm-Message-State: AC+VfDynkeJks0ApCvxupOpo9adOt8zduiTFq65PfxoMAsAw/w1p9etZ
	bN6vv7KgW4U1OwoYjGzI5Tbr1T7zwdoJjRFfYwAU6f6dV84hjH+bLcLOKwzaMUd2ksMCfc7LuL1
	K7e0xA1MZB1hVdwILdhri4nlTPp2b
X-Received: by 2002:a5d:6348:0:b0:306:45ef:9935 with SMTP id b8-20020a5d6348000000b0030645ef9935mr58032wrw.13.1684272330795;
        Tue, 16 May 2023 14:25:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UNjF+pbr8dmooWdIqHskQNKVieinLU+987Vnd4xZXoYyQEoVpnCfA2Zy805l5qzgMsii38w==
X-Received: by 2002:a5d:6348:0:b0:306:45ef:9935 with SMTP id b8-20020a5d6348000000b0030645ef9935mr58023wrw.13.1684272330458;
        Tue, 16 May 2023 14:25:30 -0700 (PDT)
Date: Tue, 16 May 2023 17:25:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516172348-mutt-send-email-mst@kernel.org>
References: <20230516030139.767838-1-parav@nvidia.com>
 <20230516013842-mutt-send-email-mst@kernel.org>
 <87lehohefn.fsf@redhat.com>
 <20230516054313-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481451FE5B75AEA9864C0E1DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516164254-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548155D503296E253EEA0395DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548155D503296E253EEA0395DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] content: Replace guest OS with driver

On Tue, May 16, 2023 at 08:59:32PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 16, 2023 4:48 PM
> > 
> > On Tue, May 16, 2023 at 07:50:48PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, May 16, 2023 6:05 AM
> > >
> > > >
> > > > SO I propose:
> > > >
> > > > \item[ACKNOWLEDGE (1)] Indicates that a transport driver has found the
> > > >     device and recognized it as a valid virtio device transport.
> > > >
> > > > \item[DRIVER (2)] Indicates that a device type specific driver was found
> > > >     and will attempt to attach to the device.
> > > >
> > > Above bisection is a implementation specific example of Linux (though valid
> > and widely used one).
> > >
> > > The UEFI virtio driver doesn't even have such two drivers.
> > > In some OS variant drivers are merged to single kernel binary.
> > 
> > which one?
> > 
> Flavor of a RHEL has inbuilt.

What does this mean exactly? That virtio core is compiled into kernel?
That does not matter at all.

> > > Does driver only matter with device_driver structure or module binary?...
> > 
> > Can't parse your question.
> > 
> > > Driver is largely the software entity that drives the device.
> > > I think we can keep the spec simple enough to not mix these details and just
> > call it a "driver".
> > 
> > Not just linux there are lots of drivers like this.  the two bits pass useful
> > information the way you changed it this distinction is lots.
> > I agree it is worth thinking what exactly does it mean.
> > Since you researched it - what exactly do drivers such as uefi and the unnamed
> > "some OS variant" do exactly?
> There is just one "driver" virtio_net_pci that has sets the required bits.
> 
> > when do they set ACKNOWLEDGE and when DRIVER?
> > 
> Not any different flow.
> Entity is one.

question is, what happens
- before ACKNOWLEDGE
- after ACKNOWLEDGE before DRIVER 
?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

