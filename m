Return-Path: <virtio-dev-return-13045-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703F9EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:05:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B6F7823D57
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:05:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A30B7986654
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:05:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8F6879865D0; Thu, 22 Jun 2023 17:05:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 676899865D1
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 17:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lviHw7YCPZeC57J_vC1DzA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687453428; x=1690045428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU5bOb1fwDJ5zNnTCuNT2umXePAegzs3lSNC9JcaNhQ=;
        b=PXHiTP7x/+4CIg+D/7BL8LJQeRXw0do3BJn3932ZMeZhV8kWHd7MCoRza8ft26D/T3
         OKf0Pp0Nm2+pZZQ1RZy1ClHcLDuRT3Y4RKmLlvqKiSCxBUQ7l9jl0phztIo8duGZZhsJ
         wcIA1vNHhDuRLtouvl0eG11e6vp97qWIX52xBKb+G9TXemZ6nRlVzy9ztbUS1dyGexcp
         QLgLwUVdljv0nzeCK5Z2+EknG3ZR+vLLhDeKz9dbRmeogWoz6AjFlDMXwkwa8WExA/t4
         csY3Do+AtkA2e7F7x9NXeyCdx65cbQyWVSBIOxH5C3fLncWRE0w4AqKFnDbNF6ySpUZw
         F6bg==
X-Gm-Message-State: AC+VfDw4vmRhk0F3J1m2OadIQcVVQWL6nar3aEbIJeL2Sl29w03jw/zX
	Bzf0qa3kaFlCxjgIN2eIdetApOI+K3uT4Ft9lq0JKmtWdHSJltSQMmC+dl0yRU5CFzwg+HXwgL3
	dR2ixQ5pgsWA6anv0wiaNsIU3cCHS
X-Received: by 2002:aa7:c64e:0:b0:518:721e:f594 with SMTP id z14-20020aa7c64e000000b00518721ef594mr13398373edr.37.1687453428242;
        Thu, 22 Jun 2023 10:03:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6c5MEUquKt7NTc7OCZDFkSmJcL7Ugif/GWNjhJ4yYGRsJ2ebHKqX6rJMw2FRcwTg6XH90uJg==
X-Received: by 2002:aa7:c64e:0:b0:518:721e:f594 with SMTP id z14-20020aa7c64e000000b00518721ef594mr13398356edr.37.1687453427935;
        Thu, 22 Jun 2023 10:03:47 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:03:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622125601-mutt-send-email-mst@kernel.org>
References: <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Thu, Jun 22, 2023 at 04:54:48PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 22, 2023 12:47 PM
> 
> > 
> > The hardware footprint of keeping this in memory is also fairly small :) I care
> > about a messy interface because this mess builds up over time.
> >
> It is really a simple GET command.
> It is actually messy for the device to implement functionality in two places in cfg space and cvq.
>  
> > And I am worried about capabilities really. My bad that I missed this change in
> > v13. I only can say in my defence that I already had to rewrite huge chunks of
> > this proposal to make it readable so one can't say I'm only delaying things, I also
> > made an effort to help this progress faster :)
> > 
> > I feel we need a single place where device capabilities can live. So far they were
> > in config space.  It's consistent, yes I get this has hardware costs *if* there's a
> > huge number of VFs and *if* there's a way to provision each VF with a different
> > configuration.  
> All the ifs are valid today.
> 
> > And yes querying VFs over MMIO is kind of ugly. But it does at
> > least work, and works fine while VF is assigned.  So we can build migration
> > around that *today*.
> >
> Other way to say migration can be skipped for this feature bit, and it still works for rest.

If VF is assigned then we can't really control what does guest enable.

> > But querying over cvq while VF is assigned clearly *doesn't* work.
> > 
> That is not the idea at all.
> Querying VF capabilities is the role of the admin command for which we built it.

This GET is exactly that though.

> > So what is the solution proposed for this?
> > 
> 1. Query member device capabilities via admin command

But that's not 1.3 material.

> > Yes the current migration is broken in many ways but that's what we have. Let's
> > build something better sure but that is not 1.3 material.
> 
> True, it is not 1.3 material, hence the proposal was to have the GET command.
> Once/if we reach agreement that no new fields to be added to config space starting 1.4 and should be queried using non intercepted cfgvq, it makes sense to let this go in cfg space.
> Else GET command seems the elegant and right approach.

I expect no such agreement at all. Instead, I expect that we'll have an
alternative way to access config space. guest virtio core then needs to
learn both ways, and devices can support one or both.

A good implementation of virtio_cread can abstract that easily so we
don't need to change drivers.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

