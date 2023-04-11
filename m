Return-Path: <virtio-dev-return-12127-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3861C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:01:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 65DC44456A
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:01:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61F6D98638E
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:01:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5410E986371; Tue, 11 Apr 2023 14:01:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 432A598636D
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 14:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1ErPvZFwPpyNYYWrPHSTzA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681221687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2JLbUUe1BmeIfMDfNz4eiRFwi4sr35xM6HAkq4/rLA=;
        b=0jWFgcTnxCTrRYewo9rg0WqDQPI44DcHhOwoWdfZupS+BAF7hQlpgRYajPVDNu/uHg
         Wl0lHbhtGh/zgNXUcploOdWDqSfpFx8ku7+FoqU8LCo6FGm8e3pbjuDtw/mcvk5IYPsf
         OXdQFEaSJnJWAVckRbPv3WvSgASiCSOxSZX9Z3DfjPTszrAFRoypG3af8rMqVHpObUvc
         iintQcNtISPRgK7Ug16tCjtLYfpkgz9NfSDaLroFzhyKaXw4RDjst2bQCKRYMOEJRo/x
         UW2t++xGdIfOVjdEsBEEEQSFd6dtYxbWb52mwlEZ6gTFw89AnTcxwawRzaFFqlERxW77
         hsfA==
X-Gm-Message-State: AAQBX9fQ1fH+eDlgBlfA7GXHUzh/effLsDQDqPJJueF1IHMMF06wpDRk
	7iWcxULqFqgzq08Wn+swZ60pFvNnJhj7TtWsSvy2ll8PLpyLHtIi0rE/Ao21ibOD7v+8asazzzw
	Tv5TdwfiiAMhowLhbTdcPP/mJsvA4
X-Received: by 2002:a5d:6d49:0:b0:2d1:7ade:aac with SMTP id k9-20020a5d6d49000000b002d17ade0aacmr10684851wri.0.1681221686879;
        Tue, 11 Apr 2023 07:01:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZIt4QarGrBe8UJ9ZAMTqctyUU/IZKzgeWWpVIhQFeggeLVjEeqVFyUSM7ms/GS087Z41ElzA==
X-Received: by 2002:a5d:6d49:0:b0:2d1:7ade:aac with SMTP id k9-20020a5d6d49000000b002d17ade0aacmr10684825wri.0.1681221686494;
        Tue, 11 Apr 2023 07:01:26 -0700 (PDT)
Date: Tue, 11 Apr 2023 10:01:21 -0400
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
Message-ID: <20230411100023-mutt-send-email-mst@kernel.org>
References: <cover.1680533760.git.mst@redhat.com>
 <9cbecf20548a7adf4d97d07b17e40eb3c1c50209.1680533760.git.mst@redhat.com>
 <2ebedc33-1fa8-1fe5-67eb-8d657cf932db@nvidia.com>
 <20230410092104-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBA1F5A746DA89CD6BF3DC959@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230410160357-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E78E40F84BBF68687F7ADC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E78E40F84BBF68687F7ADC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v11 04/10] admin: introduce virtio admin virtqueues

On Tue, Apr 11, 2023 at 01:39:32PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 10, 2023 4:05 PM
> > > >
> > > With my limited knowledge, when written for third person doing the adding
> > entries to the queue, "enqueue" is suitable.
> > 
> > Look it up in a dictionary.
> 
> Queue is verb and noun both.
> As opposed to that enqueue is not ambiguous being only verb.
> 
> When "driver queues" is read, it needs tiny more efforts to realize that queues here is verb and not plural driver queues.
> 
> So, without strong opinion, enqueue is preferred but it's up to you.

If you feel like this feel free to change all of text to enqueue.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

