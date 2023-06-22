Return-Path: <virtio-dev-return-13060-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614E4EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:36:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 93FC029FCE
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:36:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70EF09865EC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:36:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 55E749865D1; Thu, 22 Jun 2023 18:36:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 428CD9865D5
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 18:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OYV_RhaaMH21QXL41XCgjw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458978; x=1690050978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYR+R55xT1qzMX4w8Iar6TgvkBQeGL6Q70pL+qVN9sQ=;
        b=Vt/X86kzkSusejjTM52Y6Lf2bg3X9XMhXLoywW46yEhJ6s8ReZ4CH+QHjNMe+MX3vT
         TWPtGZhhvvSQyxhjew3j6n8Yuh7ZHiX2T7W+VYl/eomodFEzC1d14HkeGRiGdzDghixB
         4nIQpsA+KyhNo45j72nV8BmWl6Y2WFvF7tC1r+Zr+7YR59C2pGtmjsV8BxVc6wXkoUx7
         bGPbDWkSyVoToc4pmq7dPqkTzsWKFR1fw2SY2C6VAIYyDtDAP5Jjf8CJGbe+WfgUNp8G
         z3KQNAz2ROYBk/9D6egj9KlgpVkpwmIDMZNuDmPHu9U2irOGfURd/EfYahaos1nLvBAe
         ec9g==
X-Gm-Message-State: AC+VfDwLgdOE4FqE6XnOvXhxlwG6ql+dDGLbFo6uK1ba2/wfLpsvLvVj
	Ifs2ZHT3SRvtKC9uAkZi2uDFjEaGWC/73HOTK6K3tUlBuFM6HbUXBE2IDkUiD2ekiEVstFkJN+6
	qRXAUVErzcPkBMM2F9xkPRvSDcuSK
X-Received: by 2002:aa7:c604:0:b0:51a:3dfb:ae1a with SMTP id h4-20020aa7c604000000b0051a3dfbae1amr16581274edq.4.1687458977909;
        Thu, 22 Jun 2023 11:36:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TD7PgtVKow4k8mAsHL+Opm1sLBb3tNyxESSLQx1M0YM29TJBp1HjB2uXtiGpQQ4bR0RQTLw==
X-Received: by 2002:aa7:c604:0:b0:51a:3dfb:ae1a with SMTP id h4-20020aa7c604000000b0051a3dfbae1amr16581256edq.4.1687458977635;
        Thu, 22 Jun 2023 11:36:17 -0700 (PDT)
Date: Thu, 22 Jun 2023 14:36:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622141253-mutt-send-email-mst@kernel.org>
References: <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622120756-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812B8DA2A17EF07CBDC3F1DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622124701-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548183EB6CB52E3A719C27ACDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131120-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A92301E4D27AFA43CB0DDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622133802-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EDA41A3BA3FDF9A75E38DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EDA41A3BA3FDF9A75E38DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash

On Thu, Jun 22, 2023 at 06:12:09PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 22, 2023 1:44 PM
> > 
> > On Thu, Jun 22, 2023 at 05:20:23PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, June 22, 2023 1:15 PM
> > > >
> > > > On Thu, Jun 22, 2023 at 05:04:04PM +0000, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > > From: virtio-dev@lists.oasis-open.org
> > > > > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S.
> > > > > > Tsirkin
> > > > > > Sent: Thursday, June 22, 2023 12:54 PM
> > > > >
> > > > > > > Admin command as I recall are not accessible directly by the
> > > > > > > member driver to
> > > > > > the member device.
> > > > > > > So a cmdq or cfgq is needed.
> > > > > >
> > > > > > Possible, sure. Or we actually discussed a self group. I took it
> > > > > > away until it had a user.
> > > > > >
> > > > > The problematic part of AQ is that its index is placed in the yet
> > > > > another onchip
> > > > die register that does not scale as each member device has different
> > > > queue count.
> > > > > When admin queue was discussed, it was only for group owner, (you
> > > > answered to Jiri).
> > > > > Hence the scale is relatively less, so it was acceptable.
> > > > >
> > > > > Now having unique numbers for VFs is not good.
> > > > > Max proposal was the last index after existing defined VQs of
> > > > > num_queues,
> > > > that saves the storage space on device.
> > > >
> > > > Surely, you can just have a very large index and be done with it?
> > > >
> > > There is count of AQ too.
> > 
> > Make that same across VFs?
> >
> Queues are not infinite, so when one doesn't need it, better to not make same number.

I don't get it. Can you show an example configuration where there's
a problem? Which device type, # of data queues and admin queues desired and etc etc.

> > > For receive flow filters one may want to have multiple flowfilter_vqs as the
> > perf req is high for some vms.
> > >
> > > And device to build non linear PCI steering on the driver notification for this
> > very high q count.
> > > It is optimal to have finite and linear q max value.
> > 
> > What does this have to do with AQ? These are data vqs.
> > 
> 
> I think further. Ignore this comment.
> We need few bare minimum fields to bootstrap the device.
> So num_aq is one of them to absorb.
> This is ok.
> 
> > So 1.4 will maybe have new migration capabilities, and that is great.
> > But I do not like it that we are adding in 1.3 features that can't be supported
> > with current migration capabilities.
> For 1.3 vdpa style solution are anyway trapping the CVQ so no problem for it either.

OK I get the idea. True.
Trapping is not the same as driving or actually emulating though.
That part would be new. Certainly annoying.
Practical? Needs a bit of thought.


What's even more annoying is that provisioning would suffer too, instead
of treating all fields the same this one will have to be treated
differently.

Can't say something can't be done, but it's unfortunate that
we are adding to technical debt.

It's late here, I think I will sleep on this.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

