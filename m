Return-Path: <virtio-dev-return-12413-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD2EC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:06:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EED90600BF
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:06:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9593F9866B2
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:06:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 03B3E986475; Tue, 25 Apr 2023 20:06:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8ABCA986462
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 20:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: a1k3iCTmMAO2vhVd6QUTSQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682453103; x=1685045103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGb3wn5GJW16bf2L0e6o4R6pi6QrlJ1B1gGbI7LGcWA=;
        b=Vtey58bJR72GFJuoutyiSBbth1q0Y/FRfSwOh0xjlNqbIfg0/IdC8v+EeRjWYkBktd
         RqAu7ZtmwlLhbEswPMxbymUX26wOOeR/5G6Y6pkCDKa0KkX5e2TbDKy4AYHoUlZ4Grg5
         zTPQNFtncHdqRFzHPVH5uXHdut5dBOYaIcIps+hvBC7Xfa3BB9YX/NSEVH0y/8tYq0oc
         5u2SHW50XJejOn/JY6WxZJDEvqe0pYKRXg4vAecvmLsdYUtUCSooaX2Q7HB7sRUiDH61
         tXcq9se8SfPPr45hi+6ucNwvKXlJT2v9gLtyd65kCUtoPrgxwbytvzNdSSg7eZLj5wC2
         EGzg==
X-Gm-Message-State: AAQBX9dS1y4LY8n1k+z8sEzmLhLA0Gk5GYkfim3exyhf4L+IkKFvOl47
	gFhE+f7vDtDme6rZYrg/TZFkFy+kDnrCW+/G500RHUKI8kTQdjYWql1R7W/ty5Te+gtT4s/NrpD
	N9IVeq4VZj+UAt0MoIrF4wLS+6DEM
X-Received: by 2002:a1c:7211:0:b0:3ef:8b0:dbb1 with SMTP id n17-20020a1c7211000000b003ef08b0dbb1mr11075279wmc.7.1682453102969;
        Tue, 25 Apr 2023 13:05:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z3OShdRZML6kFo2V1r6igWLKJCxYnQVIUwumQxAbomN2m71YAIbbwbHQIirucb+R+QxDzCkA==
X-Received: by 2002:a1c:7211:0:b0:3ef:8b0:dbb1 with SMTP id n17-20020a1c7211000000b003ef08b0dbb1mr11075258wmc.7.1682453102666;
        Tue, 25 Apr 2023 13:05:02 -0700 (PDT)
Date: Tue, 25 Apr 2023 16:04:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230425160346-mutt-send-email-mst@kernel.org>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
 <20230425020925-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425092651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB7BCD1D9FF68395633BDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BB7BCD1D9FF68395633BDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 03/10] admin: introduce group administration commands

On Tue, Apr 25, 2023 at 01:38:21PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 25, 2023 9:32 AM
> 
> > > I am requesting to drop the commit point that limits the usage of the AQ.
> > > Do you agree that AQ can be extended for use beyond VF and SIOV group
> > management commands?
> > > Or one should create a new VQ type?
> > > If it is the later, I don't see the need of multiple AQ.
> > 
> > not management. that is old term and indeed too narrow.
> > administration as in hypervisor (admin) access through PF while guest has
> > access through VF.
> > 
> > legacy access you link to below seems to fall within scope:
> > we access VF through a PF.
> > 
> > So what is the problem?
> >
> Commit log confused me. You clarified above.
> It is clear now. Hence no problem.
>  
> > maybe we'll change the meaning down the road. I do not see the immediate
> > need currently though.
> > 
> As long as we agree that it is open to widen the scope, it is acceptable.
> 
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-dev/202304/msg00511.html
> > 
> > Then I don't see a problem. It's just commit log, not spec. Let it slide is my
> > suggestion, this is spec text not code.
> 
> Ok. I feel it is still worth to have commit log updated. If you happen to revise v13, please do.
> Else its fine.
> 
> v12 surely doesn't merge cleanly. So v13 is needed anyway.
> 
> Can you please generate? Patch-5 of v12 fails to apply.

should apply on top of 985bbf397db4228faf3ec464e838687dc4cb4904.  master
will fail because of the file movement.  I will need to rebase to apply
on latest master, I will do it before we start voting.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

