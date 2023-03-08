Return-Path: <virtio-dev-return-11525-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E0FC7618B
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:12:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 399BF2A8F7
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:12:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2BDDA9866FC
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:12:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1EB249866F1; Wed,  8 Mar 2023 14:12:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A8339866EF
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 14:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qnOuLSK0PQy9V9KYtIhvEA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pruHoaMxFEgALcLGx9ngc1OVBIItv+wn+Yja/fMhgI=;
        b=BpLLm9Cjy9X9++bcVo8XX9czsFkwoX894IfdOjwWjw/xGkbXf4H8OHGrT0KYs/BdF7
         SBTndNdpQeTH7EMmc3M5AqNDLgTfQwy6/3mDPEcQvj3Ijhh3VMD689SUdjM+PDRbLhra
         TM5GidZWCF4qgQKZWHRHOJNUnOipBrd5teqiTKManVBwLNNWGNsKxGQpGAtNX+33px/h
         UoZgwX+j/g+X8+Sa5KUTWNRJIB572g+MSzR94OXIwtVjEMVUMbhLNE3yMM3lR585FRs/
         RC7widdck5pF1Pk4tfWH7k62nQQup8ZexwBIafFFfJgKoelHmrxnX61FGF+Ao8uWwIak
         gdbQ==
X-Gm-Message-State: AO0yUKWgcY5sGeSQcrGeArwjdGtfZdErQ7XUM6NdAUffBz8m1+yT07zX
	mq3nC2aHZsIaQng7E2Pyw//ktrKovoYbU8hIgjCOBAyinN5ytpXu/311gHGkWaBB8qdVaRPQi/B
	5lr2LyCrJhqC5PZBgJqfW4W03jFSK
X-Received: by 2002:a5d:5706:0:b0:2c7:b8a0:c42a with SMTP id a6-20020a5d5706000000b002c7b8a0c42amr10421832wrv.31.1678284746854;
        Wed, 08 Mar 2023 06:12:26 -0800 (PST)
X-Google-Smtp-Source: AK7set9c0U9P3Im/6CdL1XjMiaqKZxxzqQrY6mFeodxNk97LC5u6vvgFrfrCXF8M1kv4D0OCCFjr6A==
X-Received: by 2002:a5d:5706:0:b0:2c7:b8a0:c42a with SMTP id a6-20020a5d5706000000b002c7b8a0c42amr10421813wrv.31.1678284746512;
        Wed, 08 Mar 2023 06:12:26 -0800 (PST)
Date: Wed, 8 Mar 2023 09:12:22 -0500
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
Message-ID: <20230308091103-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <m27cvszuta.fsf@oracle.com>
 <20230308065526-mutt-send-email-mst@kernel.org>
 <m24jqvz9ep.fsf@oracle.com>
 <ZAiH/d7igeVCt4WE@nanopsycho>
 <m21qlzz7br.fsf@oracle.com>
 <ZAiVXdawwbZ8CvXR@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAiVXdawwbZ8CvXR@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] [PATCH v10 09/10] admin:
 conformance clauses

On Wed, Mar 08, 2023 at 03:02:05PM +0100, Jiri Pirko wrote:
> Wed, Mar 08, 2023 at 02:44:08PM CET, david.edmondson@oracle.com wrote:
> >Jiri Pirko <jiri@nvidia.com> writes:
> >
> >> Wed, Mar 08, 2023 at 01:59:10PM CET, david.edmondson@oracle.com wrote:
> >>>"Michael S. Tsirkin" <mst@redhat.com> writes:
> >>>
> >>>> On Tue, Mar 07, 2023 at 11:04:33AM +0000, David Edmondson wrote:
> >>>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >>>>> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
> >>>>> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
> >>>>> > +with respective bits cleared in \field{command_specific_data}.
> >>>>> 
> >>>>> This runs contrary to the assertion "The list of supported commands MUST
> >>>>> NOT shrink", given that a driver is told to assume that
> >>>>> VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
> >>>>> commands initially available.
> >>>>
> >>>> Commands are still available just disabled, the meaning of
> >>>> "MUST NOT shrink" is clarified by the following:
> >>>>
> >>>> 	> > +after reporting a given command as supported through
> >>>> 	> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> >>>> 	> > +as unsupported.
> >>>> I will stick an "i.e." there to make it hopefully clearer.
> >>>
> >>>This puzzles me.
> >>>
> >>>I can see the point of blocking LIST_USE, but not of blocking
> >>
> >> What is that point, I'm curious.
> >
> >I might restrict the commands permitted by a device before handing it
> >off to some subordinate less trusted code.
> 
> Hmm, that is theoretical, or is there a usecase for that?
> 

Maybe there will be a future version replacing VIRTIO_ADMIN_CMD_LIST_QUERY
with a different command. Then we start with a device supporting
both VIRTIO_ADMIN_CMD_LIST_QUERY and the new VIRTIO_ADMIN_FOO,
and we block VIRTIO_ADMIN_CMD_LIST_QUERY for testing, to make sure driver
is able to handle future devices without VIRTIO_ADMIN_CMD_LIST_QUERY.


> >
> >>
> >>>LIST_QUERY. What's the purpose of this?
> >>
> >> I think that this might be just for the sake of treating all
> >> commands equally.
> >>
> >>
> >>>-- 
> >>>Time is waiting to explain, why refuse?
> >>>
> >>>---------------------------------------------------------------------
> >>>To unsubscribe from this mail list, you must leave the OASIS TC that 
> >>>generates this mail.  Follow this link to all your TCs in OASIS at:
> >>>https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
> >>>
> >-- 
> >I used to get mad at my school, the teachers who taught me weren't cool.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

