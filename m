Return-Path: <virtio-dev-return-13054-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96290EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:44:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D701B7A1CD
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:44:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD4FC98660F
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:44:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D0EE9865D1; Thu, 22 Jun 2023 17:44:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 795639865D5
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 17:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cRsn_7UZOiGMat9FAcJdiw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687455836; x=1690047836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R10AepSiRZEPuM6zqFQ4RvdWewOdAbsC1FTdjYhX3iA=;
        b=D7kB9X4dDzGbGLMd17njL6DKA4GCCjaMgbHL32q4HX+8PYinTbpU6cDn9KOQpoLTXt
         xX88fbIGll7tjzt6mKOEhaGNvCLV4bDCTSeou5no7cBniO5N8snT/pa9BotbQ3ANEUgA
         3SMGb2wj6C+ZKqLLkPHKVr1fNKFNGpg9oumUFeoxPN4MfJs7n8ChrvNVv6QP4kzD7dyQ
         Ls96wCSdlEPIQ7g3IwpBdcyZS+8vWDxCzZYe4h9YbZpLjlRM3omNkrIMekXC+f2Zc9oP
         hkSvSCvG6FpL3qbWxfcOFFfAeG9eaSkiTJuxd1ZvwvPZFz2IgbVA2uC0M1KxZWedB7Ar
         uZxA==
X-Gm-Message-State: AC+VfDx82ubqHtttDZUhd7T8eMFQqjGVO6cezx1wOSS8WTCw7R+/61R5
	CJPbVG6/GiC/DGnm9JGxQKeoOGOJqHOQvojlq3f2tL6xLh6f/Jk2OXC5scQNUeaMul0ocKcAHTb
	HoXsyBBh0q3G59A7PtgoKYD1htjLp
X-Received: by 2002:a2e:9cc5:0:b0:2b4:6c47:625d with SMTP id g5-20020a2e9cc5000000b002b46c47625dmr9797370ljj.32.1687455836471;
        Thu, 22 Jun 2023 10:43:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ498ottCrbXzBNy9tCiqu7bmhOf9nq1/JDPdKLNLnQZsPvX2vg+2lvNki6uEEjvAg0ai2iKbQ==
X-Received: by 2002:a2e:9cc5:0:b0:2b4:6c47:625d with SMTP id g5-20020a2e9cc5000000b002b46c47625dmr9797352ljj.32.1687455836052;
        Thu, 22 Jun 2023 10:43:56 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:43:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622133802-mutt-send-email-mst@kernel.org>
References: <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622120756-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812B8DA2A17EF07CBDC3F1DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622124701-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548183EB6CB52E3A719C27ACDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131120-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A92301E4D27AFA43CB0DDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A92301E4D27AFA43CB0DDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash

On Thu, Jun 22, 2023 at 05:20:23PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 22, 2023 1:15 PM
> > 
> > On Thu, Jun 22, 2023 at 05:04:04PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: virtio-dev@lists.oasis-open.org
> > > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> > > > Sent: Thursday, June 22, 2023 12:54 PM
> > >
> > > > > Admin command as I recall are not accessible directly by the
> > > > > member driver to
> > > > the member device.
> > > > > So a cmdq or cfgq is needed.
> > > >
> > > > Possible, sure. Or we actually discussed a self group. I took it
> > > > away until it had a user.
> > > >
> > > The problematic part of AQ is that its index is placed in the yet another onchip
> > die register that does not scale as each member device has different queue
> > count.
> > > When admin queue was discussed, it was only for group owner, (you
> > answered to Jiri).
> > > Hence the scale is relatively less, so it was acceptable.
> > >
> > > Now having unique numbers for VFs is not good.
> > > Max proposal was the last index after existing defined VQs of num_queues,
> > that saves the storage space on device.
> > 
> > Surely, you can just have a very large index and be done with it?
> >
> There is count of AQ too.

Make that same across VFs?

> For receive flow filters one may want to have multiple flowfilter_vqs as the perf req is high for some vms.
> 
> And device to build non linear PCI steering on the driver notification for this very high q count.
> It is optimal to have finite and linear q max value.

What does this have to do with AQ? These are data vqs.


> > > > > The single way for every device to query their capabilities is via
> > > > > a cfgvq for all
> > > > new fields without extending the existing config space.
> > > > > (and optionally old fields).
> > > >
> > > > Or adminq with self group. I like this somewhat better because we
> > > > need exactly same query from owner.
> > > >
> > > Yes. this is why I proposed to name is cmdvq that can carry admin commands
> > or other.
> > > But fine, we had to progress for group owner.
> > >
> > > > > > Why don't we focus on a work on a full solution? Just don't
> > > > > > implement this thing in your devices meanwhile until we do.
> > > > > >
> > > > > Then Heng needs to wait for cfgvq to be defined to be implemented first.
> > > > > Doesn't look reasonable to me.
> > > >
> > > > And *everything* has to wait. No, not reasonable. We somehow managed
> > > > to release several spec versions and things did not ground to a halt without
> > cfgvq.
> > > > Don't see a reason to do it right now, what's special about now? I
> > > > feel we should add to config space and then solve it all.
> > > >
> > > Things didn't ground at cost of device keep increasing their memory footprint.
> > > The latest addition I remember is the queue_reset register.
> > > It was bit but a purely control operation that got in there.
> > >
> > > > > Current GET is coherent with the new commands defined such as
> > > > > notification
> > > > coalescing.
> > > > >
> > > > > As community, we should work on defining the cfgvq, till that time
> > > > > have the
> > > > optimal way to get the config, i.e. using the cvq.
> > > >
> > > > cvq doesn't really work for capabilities though.
> > >
> > > For the device itself, it does which is what is being done here.
> > 
> > Yes but not for migration.
> 
> For migration a admin command to query capabilities is needed.
> This is present in the transport vq proposal already to be rebased on top of admin cmd.

So 1.4 will maybe have new migration capabilities, and that is great.
But I do not like it that we are adding in 1.3 features that
can't be supported with current migration capabilities.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

