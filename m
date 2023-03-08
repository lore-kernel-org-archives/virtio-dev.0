Return-Path: <virtio-dev-return-11522-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09529C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:23:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 590DC2A890
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:23:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 494E69866F9
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:23:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B8DE9866ED; Wed,  8 Mar 2023 13:23:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A2F49866F1
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 13:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ohqY5wXoPkqjgUauNWZE_A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7nIVy7XMFBtsw65vXA0HYVORj3VTm/ghmeXpuZwkwk=;
        b=p7ymc8xMVM+3v++Am3gTRKGMC+1YmgesLKd2F+sLWE/bk2+ljQRaosoanSsgV+mY+J
         vobGkW14AfxzqYha67n/XgU3mpFQ54ElCeiWEnIaIWecFQQ2+tasVVGoBl+2fjg6yWWt
         W2Z6qAGGmRvGlYtDy39N/+vQXJegwpVnsegU0VSxtjYXNJNcrN0UF44b9otaDuZc1liz
         dO9nnC/sNDR94lOnw2MFCRtBgi4kqokPAxqMEkOzXVVYibwMi8JGqOojg3ZgFPHSfJpZ
         C3KvnN+ZZoIbsfo7xz60doIWhRmfuQ6e8u8o/rk8CaZM7jJSYsOqzo0ia7fLT1Dx3njq
         +BEg==
X-Gm-Message-State: AO0yUKWp392zWhS52cuzLGv/M8Wx9FsS91xD5eXAMCR/4OWJ0CRG++Lg
	GoSxXvX2bEIR0HUxZVcQVSysRH4GDr6cgc2rmHyT/69l3iUovZjFKNglRoisFhkaDd733E9qkns
	bGoiODZeiPbnd79TgbcQsolvi1fLQ
X-Received: by 2002:aa7:d7c5:0:b0:4ae:f496:1372 with SMTP id e5-20020aa7d7c5000000b004aef4961372mr15743952eds.36.1678281778059;
        Wed, 08 Mar 2023 05:22:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8XAnNJnBoaxgumFKLGBOh664EsyZl6xvAh4/uBiCl06zTfCfrz3iIsJBl6dJOflzDY5G0mjg==
X-Received: by 2002:aa7:d7c5:0:b0:4ae:f496:1372 with SMTP id e5-20020aa7d7c5000000b004aef4961372mr15743919eds.36.1678281777504;
        Wed, 08 Mar 2023 05:22:57 -0800 (PST)
Date: Wed, 8 Mar 2023 08:22:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230308082055-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <m27cvszuta.fsf@oracle.com>
 <20230308065526-mutt-send-email-mst@kernel.org>
 <m24jqvz9ep.fsf@oracle.com>
 <ZAiH/d7igeVCt4WE@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAiH/d7igeVCt4WE@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] [PATCH v10 09/10] admin:
 conformance clauses

On Wed, Mar 08, 2023 at 02:05:01PM +0100, Jiri Pirko wrote:
> Wed, Mar 08, 2023 at 01:59:10PM CET, david.edmondson@oracle.com wrote:
> >"Michael S. Tsirkin" <mst@redhat.com> writes:
> >
> >> On Tue, Mar 07, 2023 at 11:04:33AM +0000, David Edmondson wrote:
> >>> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >>> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
> >>> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
> >>> > +with respective bits cleared in \field{command_specific_data}.
> >>> 
> >>> This runs contrary to the assertion "The list of supported commands MUST
> >>> NOT shrink", given that a driver is told to assume that
> >>> VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
> >>> commands initially available.
> >>
> >> Commands are still available just disabled, the meaning of
> >> "MUST NOT shrink" is clarified by the following:
> >>
> >> 	> > +after reporting a given command as supported through
> >> 	> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> >> 	> > +as unsupported.
> >> I will stick an "i.e." there to make it hopefully clearer.
> >
> >This puzzles me.
> >
> >I can see the point of blocking LIST_USE, but not of blocking
> 
> What is that point, I'm curious.
> 
> 
> >LIST_QUERY. What's the purpose of this?
> 
> I think that this might be just for the sake of treating all
> commands equally.
> 

Right. There was this vague idea that blocking all commands
is good to have. E.g. if you are making some drastic
changes to the device?


> >-- 
> >Time is waiting to explain, why refuse?
> >
> >---------------------------------------------------------------------
> >To unsubscribe from this mail list, you must leave the OASIS TC that 
> >generates this mail.  Follow this link to all your TCs in OASIS at:
> >https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

