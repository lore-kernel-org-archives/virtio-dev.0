Return-Path: <virtio-dev-return-13471-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F45C001DF
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 10:33:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A4FF0190918
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 10:33:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C09398684D
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 10:33:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8FD869866DE; Fri,  4 Aug 2023 10:33:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7963E9866E1
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2023 10:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: X1JkVo1hOmOJewCD_BwIAw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691145205; x=1691750005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jt0Bni4kidfjGJ3E7mDNNcg+EgaVQeiqUUoIVUDZc8=;
        b=CxiuAzNOAOG4pxrUfjiXDEnGhV8tIVwoAoBAZ8VseOZurcKDY3iE8yplENSPpPE7bn
         70EZOBVDUlVD0Fg2C9NptCzhKPXryC+yq5FY+W5oUFmDtGSJvbP3Q8LCUAbXQ+LzZiNn
         M603kyY/SMtiNSBfIjiT63nKdvrw8lSwxGVQZAiuY7S9ypJhgZX0wc6YGtKZ2eJWBuLL
         +1TjEs4tmy11j1m6WX1escTqWTR92mwqqO4zndfcNBZfMxB3NMl2h1aqFQS6Vh4D2cRR
         WxYuo6XRL6LCPBajnbARPa3AH4KEsO7bHrvPVzOAk2l0aDtH/9YzAApOy0Lb4bZsk2hU
         S1Jg==
X-Gm-Message-State: AOJu0YwhC+8lu4A5rcvoGn5VGnrQZxUVvr1OiAahivRFAgcSIeLKY2RG
	7bVQIq3BkLiaQ0iN3odDCpyZ501a7dOLgx1PEduyxZQOttMNh+DIdhflILMhKCqC6PsRNegjmJ6
	f1gZtNYFCYyx2tMisb2xd7pr0RBXz
X-Received: by 2002:a05:6402:11ca:b0:522:b9ae:db3c with SMTP id j10-20020a05640211ca00b00522b9aedb3cmr1752922edw.6.1691145205127;
        Fri, 04 Aug 2023 03:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtm85LDTnKNKq4UJ+bvRc84cDaOHg6AhdSZHYeI2gQqvnJ0BcP5RcpQ86uBefZcTuO00IrEw==
X-Received: by 2002:a05:6402:11ca:b0:522:b9ae:db3c with SMTP id j10-20020a05640211ca00b00522b9aedb3cmr1752905edw.6.1691145204833;
        Fri, 04 Aug 2023 03:33:24 -0700 (PDT)
Date: Fri, 4 Aug 2023 06:33:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Message-ID: <20230804053958-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net:
 support access and control the member devices

On Fri, Aug 04, 2023 at 03:44:57PM +0800, Xuan Zhuo wrote:
> On Fri, 4 Aug 2023 07:26:01 +0000, Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Friday, August 4, 2023 12:24 PM
> >
> > > I know the gap. For us, the switch is under all devices(including the owner
> > > device).
> > > So we need to control the switch separately.
> > >
> > Right. Same for other devices too, including ours.
> > Hence, it is also located outside of the owner device (on a different system).
> >
> > If the switch is not a virtio device, does it really need to be exposed as virtio object?
> >
> > > In your structure, the owner device works as the switch. It has port to connect
> > > to the vf devices.
> > >
> > Right. I just put owner device as switch for simplicity of the discussion.
> >
> > At this point to have port for owner device requires creating a dedicated switching object, to be located sometimes side by side inside the owner, sometimes outside.
> > All of these cases to be crafted, please rethink if this is _really_ needed as virtio object or not.
> 
> 
> YES.
> 
> We can hear others.
> 
> @Jason @Michael
> 
> 
> Thanks


This is so abstract, hard to have any position as I'm not sure what
we are discussing. If some virtio devices have an integrated switch
then ability to control the switch through virtio seems useful.

Re:queues - it's not by chance that we have multiple admin queues.
So driver can dedicate one queue to filtering commands if
that's felt to be important.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

