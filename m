Return-Path: <virtio-dev-return-13042-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917DFEB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:46:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D38C9C6113
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:46:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC7409865F1
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 16:46:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 947EB9865D1; Thu, 22 Jun 2023 16:46:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F3769865D4
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 16:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2setTLo5M4GoJimRUwYQfg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687452402; x=1690044402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G87f9X9Qfo4MofAhUuFAvCKjRI6hHAhdiqhm4oq8POM=;
        b=UCJTjhWa6raBA5vhCnwjIHoEdZ8xlmO0d6ICtp9sQvjiwlYpnzCDza0cVCs7QSxccU
         t357/AkG3LYhI+PihAwjd29Yl765LtUoKve+1UVLaJ3l8VMw/7mlaBBcdQgq997dkT8h
         YiPtux05tc8p5fjzzV4chGjcwl1Cz1mmwxvXXuIXyIjqz14DWdDIHy8+YyGjwSdiuNid
         sJk68OomkRYEAh2zB8zjxdNBvW18QkaE+W51JTPZ4oB4XJotnBa2cG1PSoOkTv5tCy4k
         6DB4I1AqqGaCxGQyBF8r17fMlgEFdB8X8OhYvSyzdyBxtM03wgLsmzoeG5RRAkbPMUDE
         z0TQ==
X-Gm-Message-State: AC+VfDy6bJyJpvjkWsctkxbjU7/8kAcxFqlqs2TC1i69FJ159bRY9ddS
	g+yU5RT5OkzF6f3JjBj9NOUqo2IV4I5IsLD4U8NHrP/EI4fhBZx42ibLgszSK5PYNA3l5N8m4rz
	spdrfeSj+7UkgjiAm2GioElW1rM/Q
X-Received: by 2002:a17:907:9702:b0:988:107a:5e40 with SMTP id jg2-20020a170907970200b00988107a5e40mr13850342ejc.31.1687452402751;
        Thu, 22 Jun 2023 09:46:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DEV7lUrdASk8dItWbl+0nKdihRqA7MBTppKMSi7bcDtX75MI+UxgTo7CYqouPCwxx9BlwlQ==
X-Received: by 2002:a17:907:9702:b0:988:107a:5e40 with SMTP id jg2-20020a170907970200b00988107a5e40mr13850315ejc.31.1687452402375;
        Thu, 22 Jun 2023 09:46:42 -0700 (PDT)
Date: Thu, 22 Jun 2023 12:46:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622123203-mutt-send-email-mst@kernel.org>
References: <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Thu, Jun 22, 2023 at 02:27:31PM +0000, Parav Pandit wrote:
> 
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Thursday, June 22, 2023 9:43 AM
> > 
> > Yes, I think we also have to consider upcoming
> >      1. device counters (e.g. supported_device_counter),
> >      2. receive flow filters (e.g. supported_flow_types, supported_max_entries),
> >      3. header splits (e.g. supported_split_types) etc.
> > Continuous expansion of the configuration space needs to be careful.
> > 
> > >
> > > Instead of decision point being RO vs RW, any new fields via cmdvq and
> > > existing fields stays in cfg space, give predictable behavior to size the member
> > devices in the system.
> > > Once the cmdvq is available, we can get rid of GET command used in this
> > version for new future features.
> > > Till that arrives, GET command is the efficient way.
> > 
> > Yes, I agree.
> > 
> > Thanks.
> 
> Right. So, Miachel main concern was two vs one struct.
> And given the GET and SET works on different fields, having two structure is just fine.
> The code is fairly small.
> I don’t see any real issue here with v18.
> 

The hardware footprint of keeping this in memory is also fairly small :)
I care about a messy interface because this mess builds up over time.

And I am worried about capabilities really. My bad that I missed this
change in v13. I only can say in my defence that I already had
to rewrite huge chunks of this proposal to make it readable
so one can't say I'm only delaying things, I also made an effort
to help this progress faster :)

I feel we need a single place where device capabilities can live. So far
they were in config space.  It's consistent, yes I get this has hardware
costs *if* there's a huge number of VFs and *if* there's a way to
provision each VF with a different configuration.  And yes querying VFs
over MMIO is kind of ugly. But it does at least work, and works fine
while VF is assigned.  So we can build migration around that *today*.

But querying over cvq while VF is assigned clearly *doesn't* work.

So what is the solution proposed for this?

Yes the current migration is broken in many ways but that's what we
have. Let's build something better sure but that is not 1.3 material.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

