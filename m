Return-Path: <virtio-dev-return-13036-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC42AEB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 06:23:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D7B8179128
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 06:23:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C76498662A
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 06:23:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7247498626D; Thu, 22 Jun 2023 06:23:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A6839865D1
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 06:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 50OJdv4mPdCoPm52-vAmyg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687415011; x=1690007011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIr+/DcU/Q5ols09ga5xI7N071LMzU7R1IernlYz5eQ=;
        b=Fjz7WtncRYZZgvURYaX2xx3lECWlDy0eKCIgNhDZoHUKx0mIaWdpwFjrn4pcuf5Z7k
         68ziHCuFjpTAZr19Ok+mLlemuSQ22/iCx6p9gDX97ypheonOfSHTQAL5J+Bb3hyyYKXa
         /PCbClQT86p4RaOG1fMMEksBrr2rQ02rI5DbAOBeH2yAATteJe1cRQVm9KNoZBIsL5wy
         dS980H4VA6dzYisj9mBnGOrkjg/a/PplraUcKNXnqWM5NB0R8TJiQY3yNvOffsq1bf2V
         Uw56SK14b5Z9cYuZnt+/Qjp52O7JniW+vPARU9eEozJZyj6u9hXL17EvH7n8EYJOeky7
         Y1Qg==
X-Gm-Message-State: AC+VfDxv69KRpYytrq+kE+mZ0BKdxJ905IrwNqzhck89ZsfDEL0gUN8I
	2X5eHQ2kUJXbvnPtsqn0CLvhAI9GobS5d4LDQQ4gZ+orj0vFItqg9V4y1Ho3aQvPZpLHq6m8SbZ
	HYmqjRi+zZ33i1sIfG1ZtEYXJdvI2
X-Received: by 2002:a17:907:1c95:b0:987:15ee:4399 with SMTP id nb21-20020a1709071c9500b0098715ee4399mr15749492ejc.29.1687415011048;
        Wed, 21 Jun 2023 23:23:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+FtoIJpYqYh+6D9d+xoUXb1bQAx+JOAYg8FrKbS4AZ/YtQWU7198P7PQeo++eFQZWTbEhLA==
X-Received: by 2002:a17:907:1c95:b0:987:15ee:4399 with SMTP id nb21-20020a1709071c9500b0098715ee4399mr15749480ejc.29.1687415010703;
        Wed, 21 Jun 2023 23:23:30 -0700 (PDT)
Date: Thu, 22 Jun 2023 02:23:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622021932-mutt-send-email-mst@kernel.org>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 21, 2023 at 08:52:04PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 21, 2023 4:38 PM
> 
> > > > And the field is RO so no memory cost to exposing it in all VFs.
> > > Two structures do not bring the asymmetry.
> > > Accessing current and enabled fields via two different mechanism is bringing
> > the asymmetry.
> > 
> > I guess it's a matter of taste, but it is clearly more consistent with other hash
> > things, to which it's very similar.
> >
> This is consistent with new commands we define including notification coalescing whose GET is not coming config space.

But there GET just reports the current state. Not the read only
capability. So there would be cost per VF to keep it in config space.
This one is RO no cost per VF. Let's make it convenient?

> > 
> > Nah, config space is too convenient when we can live with its limitations. I don't
> > thin kwe prefer not to keep growing it.
> > For some things such as this one it's perfect.
> >
> Fields are different between different devices.

Not sure what's the implication?

> > For example, for migration driver might want to validate that two devices have
> > same capability. doing it without dma is nicer.
> > 
> A migration driver for real world scenario, will almost have to use the dma for amount of data it needs to exchange.

Not migration itself, provisioning.

> > Another example, future admin transport will have ability to provision devices
> > by supplying their config space.
> > This will include this capability automatically, if instead we hide it in a command
> > we need to do extra custom work.
> > 
> > > So we do not prefer to keep growing the config space anymore, hence
> > > GET is the right approach to me.
> > 
> > Heh I know you hate config space. Let it go, stop wasting time arguing about the
> > same thing on every turn and instead help define admin transport to solve it
> 
> This was discussed many times, a driver to have a direct (non-intercepted by owner device) channel to device.
> If you mean this non-intercepted channel as admin transport, fine.

we can do that, sure.

> If you mean this is intercepted and it is going over admin cmd, then it is of no use for all future interfaces.
> 
> We discussed this in thread with you and Jason.
> I provided concrete example with size and device provisioning math too and other example of multi-physical address VQ.
> So transporting register by register over some admin transport is sub-optimal.
> 

Not register by register, we can send all of config space as long as
it's RO. This field is.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

