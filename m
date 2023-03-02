Return-Path: <virtio-dev-return-11355-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E57C7EE30
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8BE412AEE5
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id 784232A8C7; Thu,  2 Mar 2023 08:20:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7436E986672
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 08:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677745150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsj4gw8eOT9LdA+6gyH7R3o0TvSBiMHhi7t9smJowvY=;
        b=LV9Rmc9ZVlGTe0YHK7rtgElKCQiqurNjgcJB957oZH38263r+JcsDNEc3hRmJr5brA
         uqQIJxZCRX32xa9ajvdcIe8SEANK8iNUN1hNWjG6/p9DzzPVMt3BvSyqDtaMcuMHlQDJ
         Amk0GxisBvfvnc2EycwY9gH/Dr6bn5VpQN4hZ3++Zrscq1Cm908czZcq3z8pFN9zozh0
         5v0drTXuWeMF/fCnisG1VcJ/XmfWrM1dAdOOVhnPXDdH47dCvLh7OJYzW1d5081MnQaA
         cSwMIPBHRxE2boL3uxNZ7lFXrOjUKCtyan18xz9DY32jijNRV43JkXWNnVJGBBY5aOYh
         lKlA==
X-Gm-Message-State: AO0yUKUztE1znIF6a/hINqaonmXz8G7PjqH2vEtJCAb/eqGcEX+e5yg3
	WFiR0eJAqPLFbSkCDORwTdc6Mw==
X-Google-Smtp-Source: AK7set/R/7m2YH2OxVBgHgIHB3sQI/WMTf6qYCSQuViRUx1uXw/vsbHB8XOHZu3eZC8ih4eXLUxj+Q==
X-Received: by 2002:a05:6a00:a81:b0:5a8:aa5e:4bc3 with SMTP id b1-20020a056a000a8100b005a8aa5e4bc3mr1878722pfl.1.1677745149672;
        Thu, 02 Mar 2023 00:19:09 -0800 (PST)
Date: Thu, 2 Mar 2023 13:49:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230302081907.pwt4nvz5buyt2dz3@vireshk-i7>
References: <Y/9zkDAS4odz93GM@fedora>
 <877cw0ctpr.fsf@linaro.org>
 <Y/+LdfF0rL3wEqfd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/+LdfF0rL3wEqfd@fedora>
Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
 mapping support

On 01-03-23, 12:29, Stefan Hajnoczi wrote:
> What is the advantage over defining separate messages? Separate messages
> are cleaner and more typesafe.

I thought we wanted to keep single message for one kind of functionality, which
is mmap related quirks here. And so it would be better if we can reuse the same
for next hypervisor which may need this.

The value parameter is not fixed and is hypervisor specific, for Xen this is the
domain id, for others it may mean something else.

> I don't have a concrete example, but was thinking of a guest that shares
> memory with other guests (like the experimental virtio-vhost-user
> device). Maybe there would be a scenario where some memory belongs to
> one domain and some belongs to another (but has been mapped into the
> first domain), and the vhost-user back-end needs to access both.

These look tricky (and real) and I am not sure how we would want to handle
these. Maybe wait until we have a real use-case ?

> The other thing that comes to mind is that the spec must clearly state
> which mmaps are affected by the Xen domain information. For example,
> just mem table memory regions and not the
> VHOST_USER_PROTOCOL_F_LOG_SHMFD feature?

Maybe we can mention that only the mmap's performed via /dev/xen/privcmd and
/dev/xen/gntdev files are affected by this ?

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

