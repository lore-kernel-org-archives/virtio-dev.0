Return-Path: <virtio-dev-return-11572-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C3C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:57:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 221DA33572
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:57:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A41D986700
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 13:57:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0E61D9866F6; Thu,  9 Mar 2023 13:57:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFD919866FB
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 13:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wJeOaDEPPb-ll8kC4kx8_A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBLmwFBOHDw6t8kGtGh293Y7qqAxNo+s9fLtldRHTkU=;
        b=zJ995P6k9W6XT4rXEtQgMYUjUpnA3jhPtaoYBxCg4Wkr1lCN7QlWIyZjaHmsPzKCP0
         8tPgMn0wx0CCCzSKO54LW7a6qpVCrT/sD+8bUNAhvAXjDQlh5PwvKkrbUwo21OlooWmD
         VZkDWWsvGKVKG5nKZBceG4Jg9ULxrKsOqFG8lw3COrJi0ggGNSOFZyJcK1lMM+lqvXOM
         uPPUNonw2Ot6sZtpfe1DqRA/nzY13ZuaABe+HGj6Dv6jBatcA6NlM+WF2lDvH+2pfTcZ
         FLKJL4BksHarKDgEdCESkc09oDAxwQgePUkUn4Fs7m9z3Ht4WXz5aqV8STRkanmN8TsV
         ZYTg==
X-Gm-Message-State: AO0yUKXhD0VdWQc2AEdAMu1V3e2C//QBbXgkqk2t/CN9Ca8uKgV0S75S
	4087Lw4ANnM3zgy5qRPHDGlW4wMk2S+Rhl9yUsTpKePq8/RTmPkqHpBUEOVBECCdikZkPbHgb+v
	JCMcl6VPHhCRoQDMI+/l+4/ZmZFxc
X-Received: by 2002:aa7:de11:0:b0:4ab:497a:2e84 with SMTP id h17-20020aa7de11000000b004ab497a2e84mr21716549edv.12.1678370253115;
        Thu, 09 Mar 2023 05:57:33 -0800 (PST)
X-Google-Smtp-Source: AK7set/cEpxjaZSjB4LBAX1xlcoMbUPbOy2fJkK53hGDSOrPbboBzxL1bqLN5Tp6B9c3Dlbq68KYdg==
X-Received: by 2002:aa7:de11:0:b0:4ab:497a:2e84 with SMTP id h17-20020aa7de11000000b004ab497a2e84mr21716525edv.12.1678370252864;
        Thu, 09 Mar 2023 05:57:32 -0800 (PST)
Date: Thu, 9 Mar 2023 08:57:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jiri Pirko <jiri@nvidia.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230309085605-mutt-send-email-mst@kernel.org>
References: <ZAbpiRVdo8BciELX@nanopsycho>
 <20230307111458-mutt-send-email-mst@kernel.org>
 <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org>
 <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com>
 <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

On Thu, Mar 09, 2023 at 01:04:30PM +0000, Parav Pandit wrote:
> 
> > From: Jiri Pirko <jiri@nvidia.com>
> > Sent: Thursday, March 9, 2023 2:31 AM
> > 
> > Wed, Mar 08, 2023 at 10:25:32PM CET, parav@nvidia.com wrote:
> > >
> > >> From: virtio-comment@lists.oasis-open.org
> > >> <virtio-comment@lists.oasis- open.org> On Behalf Of David Edmondson
> > >
> > >> In support of live migration, might we end up moving large amounts of
> > >> device state through the admin queue?
> > >>
> > >Correct.
> > >
> > >> If so, that would seem to have some performance requirements, though
> > >> I don't know if it would justify multiple admin queues.
> > >DMA of the data through the proposed AQ is supported.
> > >
> > >If I understood Max correctly when Max said " This AQ is not aimed for
> > >performance ", he means that AQ doesn't have performance requirements as
> > io/network queues to complete millions of ops/sec.
> > >
> > >it is several hundred to maybe (on the higher side) thousand ops/sec during
> > LM, provisioning use case.
> > 
> > But isn't it good to design it for performance from start? I mean, state transfer
> > of thousands of VFs at a time is definitelly performance related, isn't it?
> > 
> It is. Which part of the proposed AQ doesn't cover this aspect?
> The only issue that I see today is, that a given GET family of commands q contains the read-only and write-only descriptors which require multiple dma allocations on driver side.

BTW for a while now I wanted to add a descriptor flag that
will stick data inline in the descriptor. Perfect for passing
small bits of data such as vqn, or the virtio header.


> > 
> > >
> > >DMA perspective as you mentioned, AQ still has the same perf requirements
> > as that of regular nw/blk io queues.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

