Return-Path: <virtio-dev-return-12243-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79569C77B73
	for <virtio-dev@archiver.kernel.org>; Sun, 16 Apr 2023 20:44:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 613732A82D
	for <virtio-dev@archiver.kernel.org>; Sun, 16 Apr 2023 20:44:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17A589863D9
	for <virtio-dev@archiver.kernel.org>; Sun, 16 Apr 2023 20:44:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F185E986288; Sun, 16 Apr 2023 20:44:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D00EC98667B
	for <virtio-dev@lists.oasis-open.org>; Sun, 16 Apr 2023 20:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0uexE295M1uTzTyMzd3AaQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681677870; x=1684269870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcFEZbNI5d2z3cJh5ThbBpEMo4clcPq77geY9l+6Mpc=;
        b=j7ZuVL6G0pKsgOAjyoaoQn7X+H5ANrYUjXVez7Qs9iAHns0yz7XtVgwt8aU0PimzxZ
         My3rsiKBtR7QH+DQYl5IsMpLgyzGbESTEJ1kyFib0V+Q48imtt7jgOvI8VMoJzm1a86t
         2erbtULCaPBPQM1UMuXQHSLn/kzHSjithyCZPjmDQjvGEJzgbMp9F65ozJvNhsUsVjBX
         jGhdjmlHNWRXrFPl4rSbWvR0Ug8zpDMoJ9evGhIrhnH2rZjErUHd2BiODotHS7rAoPYT
         FEOzyUuVRErE6RYFINXvjopCn/7ldNxROGsQNjPwXtoCfhj5efYojerKnZ0WDQ1BgQtU
         ydNA==
X-Gm-Message-State: AAQBX9d7/eEzoAtFjWPpCFHeggfLw9WkkrcBhnDHgw8BHk2XJd8Uqa2B
	N0+Qe76y1wcIZL5tAyhd9dSkbGB58T4y/VOGIcQHwm61WYhUAs/Q6mFTMfqHCjXt4RMrHJATy5T
	Aw/U+5C/HPvHr4iDiIFpxprlgc5B5
X-Received: by 2002:adf:dc91:0:b0:2d9:81b2:322a with SMTP id r17-20020adfdc91000000b002d981b2322amr4023535wrj.55.1681677870066;
        Sun, 16 Apr 2023 13:44:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350bpnxkBwTlSX/jTknjSEm/jhodfMxIAANe8O9aq3p506Ack5mdtkYxkYUZt9w2lW3kwPB8Huw==
X-Received: by 2002:adf:dc91:0:b0:2d9:81b2:322a with SMTP id r17-20020adfdc91000000b002d981b2322amr4023523wrj.55.1681677869770;
        Sun, 16 Apr 2023 13:44:29 -0700 (PDT)
Date: Sun, 16 Apr 2023 16:44:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230416163929-mutt-send-email-mst@kernel.org>
References: <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
 <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230414025523-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F9D94282F794E0A08BF0DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F9D94282F794E0A08BF0DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Sun, Apr 16, 2023 at 01:41:55PM +0000, Parav Pandit wrote:
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> > Sent: Friday, April 14, 2023 2:57 AM
>  
> > Do you refer to the trick Jason proposed where BAR0 is memory but otherwise
> > matches legacy BAR0 exactly? Is this your preferred solution at this point then?
> 
> We look at it again.
> Above solution can work reliably only for a very small number of PF and that too with very special hardware circuitry due to the reset flow.
> 
> Therefore, for virtualization below interface is preferred.
> a. For transitional device legacy configuration register transport over AQ,

I don't get what this has to do with transitional ...

> Notification to utilize transitional device notification area of the BAR.

The vq transport does something like this, no?

> b. Non legacy interface of transitional and non-transitional PCI device to access direct PCI device without mediation.

So VF can either be accessed through AQ of PF, or through direct
mapping?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

