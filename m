Return-Path: <virtio-dev-return-12339-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DACDC77B78
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 05:43:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 610F03E30E
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 05:43:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9CB4986668
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 05:43:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 911B2986686; Fri, 21 Apr 2023 05:43:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5373098663B
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Apr 2023 05:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gomW9p8AM0WHqa-MTBcIZQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682055825; x=1684647825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3pbInikhMeZSfdaxQvw+Ul7ae3bI6PoC4SdBdK79ac=;
        b=X1S1BXub2T3D3PpD5CTUzEWOEO9iHvTM7XiTHW6A0Oou08/GHW8HAKNi5W6wnDXxxU
         CVkHHuRfijt0ZdffXpL9un+58JZ0pHfAc68dIDvVzh+ULPu86usIPDU4yIJFmkzrKuX6
         T1uwaXSKcg0Akv3KsG7bWWzFajY5ViSSGyT+gfU2ovE6IS9H+7xFrHMV0XA+Qa1Zf1XV
         EiembC1V+XLiVdBMusg/iH1X4iRmpBQruZykH5FE9bGm4nF7/p7Qy80JxhZbd4taJoyD
         CtlLRCvTieJbtrVtOezq5id+OzCwIClVM9r1k2+aEKnmeVO4fSReeX6HyNQt4SOO2fDU
         9Fqw==
X-Gm-Message-State: AAQBX9f+pmWUCV5CCAC+aLfJDOmrl31Ct5xFwrI/STtMoWui0w0LXwp3
	7b6Si8P7Dh9KJzVxYAS8nDxnOmuA89WCaUd2TzSEEbm1yX0NfX/pXYammW5NzGpwrmTZ2ppaSPO
	B/UVfIbyqzh7cbyzj126vy86zLvsu
X-Received: by 2002:a05:600c:24cd:b0:3f1:73ce:e1dd with SMTP id 13-20020a05600c24cd00b003f173cee1ddmr800193wmu.10.1682055824990;
        Thu, 20 Apr 2023 22:43:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350aC/Tux1oNoEUaqWQomhRYVtHmmHvuxCO8tIa7cU6+5R5lKcV6tUFW5bkywUeQN4SPMdvYoWA==
X-Received: by 2002:a05:600c:24cd:b0:3f1:73ce:e1dd with SMTP id 13-20020a05600c24cd00b003f173cee1ddmr800187wmu.10.1682055824682;
        Thu, 20 Apr 2023 22:43:44 -0700 (PDT)
Date: Fri, 21 Apr 2023 01:43:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230421014212-mutt-send-email-mst@kernel.org>
References: <20230420195158.69737-1-parav@nvidia.com>
 <20230420195158.69737-2-parav@nvidia.com>
 <20230420163800-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548172381252BEB73CAE6D44DC639@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548172381252BEB73CAE6D44DC639@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 1/2] transport-pci: Improve config msix
 vector description

On Thu, Apr 20, 2023 at 08:51:57PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, April 20, 2023 4:45 PM
> > >  \item[\field{config_msix_vector}]
> > > -        The driver sets the Configuration Vector for MSI-X.
> > > +        The driver writes the MSI-X table entry index in this field for
> > > +        Configuration change notification interrupts.
> > 
> > 
> > Urm not exactly. there is also a special value of 0xffff.
> > I feel this here is just a high level description.
> It is high-level description. 0xffff is already covered elsewhere in the doc.

So make it as brief as possible then.

> > how about
> > 	Used by the driver to set the MSI-X vector for Configuration change
> > notification interrupts.
> > 
> > pci spec also calls the entry "the vector" so I feel it's ok.
> > 
> 
> To keep the text consistent with rest of the fields, how about
> 
> The driver writes the MSI-X table vector in this field for Configuration change notification interrupts.
> It uses a single verb instead two = "used" and "set".
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

