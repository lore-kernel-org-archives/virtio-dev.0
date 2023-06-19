Return-Path: <virtio-dev-return-12968-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BD3EB64DB
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:40:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C918142577
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:40:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE7EB98650C
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 16:40:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AF0E99863A9; Mon, 19 Jun 2023 16:40:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D7F09863E1
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 16:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JBWTAuwLMQOK36rtScgJKQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687192833; x=1689784833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v0Lt+PCTfdBya1XTMNg1bFqIV3nrVKNz0YQP65aQzM=;
        b=F2VTrT5fYlyWQA5U1HEImFxZyLGtqz/Qyv0W1GBO0maHmBUF8o/j0nzbaRPlyIz7bO
         ewhOxFAiTnFwDBpaVq4km4IzQYVVBrovD0i22NF/wxa/llJjqytCyZL4+eBpSUtvyDwc
         jaJK6y/cVfh5XfQI/Hh/Xcj59HSL8ocGtox7mw2V7M/vQ1xWh4oBUmcRULesOY+Qn+t2
         s6xRRJBsTx60/KDFubo1RnUdBrWNsCFB/W/KwdeiRPYpaMilhIw954YJ+iDD2jtJqVaq
         sKsUaVRJGTcg/G/MGxNI9xhvHjPjuNRVf60McoyT/EelcjLcI5f5CisABBchhbpzxLsO
         aImQ==
X-Gm-Message-State: AC+VfDxAp/2DZaPWRBhxZ4V/TGTMiFypKG4QEiKjH5K3WT0v4jc+Zbtf
	kMQ0VDYgPenaPGph4+jXyc1Qa79bPlVJVdS/FXtqnjt0NJwWHexyQai2wwTMFUT2A6Vu0gI4OoI
	wboZNPmaau8/EPdWew16Ayq9A9/7G
X-Received: by 2002:a7b:c84f:0:b0:3f8:fed0:1c5c with SMTP id c15-20020a7bc84f000000b003f8fed01c5cmr5759738wml.8.1687192833202;
        Mon, 19 Jun 2023 09:40:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Sae/GAxFnyEmkDfNxSPzfLIiwzlEcTN4wLhLukZy0QQijGiNXctoGtXckwVg+GQTaDhL7tQ==
X-Received: by 2002:a7b:c84f:0:b0:3f8:fed0:1c5c with SMTP id c15-20020a7bc84f000000b003f8fed01c5cmr5759725wml.8.1687192832909;
        Mon, 19 Jun 2023 09:40:32 -0700 (PDT)
Date: Mon, 19 Jun 2023 12:40:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230619123757-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-4-parav@nvidia.com>
 <20230619121724-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EE01C25B4C170E498177DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EE01C25B4C170E498177DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 3/4] admin: Add group member legacy register access
 commands

On Mon, Jun 19, 2023 at 04:29:43PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 19, 2023 12:21 PM
> 
> > > diff --git a/admin-cmds-legacy-access.tex
> > > b/admin-cmds-legacy-access.tex new file mode 100644 index
> > > 0000000..89a4f49
> > > --- /dev/null
> > > +++ b/admin-cmds-legacy-access.tex
> > > @@ -0,0 +1,138 @@
> > > +\subsubsection{Legacy Interfaces: legacy configuration access
> > > +commands}\label{sec:Basic Facilities of a Virtio Device / Device
> > > +groups / Group administration commands / Legacy Interfaces: legacy
> > > +configuration access commands}
> > 
> > I think this is where all the theory of operation text should go.
> >
> This is where most of the theory of operation is documented which is agnostic of the transport.
> PCI specific things are left in pci transport section.

what I am saying is that it's cleaner here at least for now.

> > > +
> > > +The group owner device can optionally enable the driver to access its
> > > +member devices legacy common configuration and device configuration
> > > +region
> > 
> > we can just say "the legacy interface of member devices"
> > 
> What is the harm in telling explicitly what is currently supported, specially when it theory of operation description section.

The harm is that
- making things generic on the 1st try is the only stick we have
  as contributors always push to make their solutions as
  specific to their needs as possible
- people are lazy and they will copy text and then
I get to repeat this argument all over again.

If you want to also have a type specific text, be my guest
"specifically, for an SRIOV type" .... 


> > > using following listed
> > 
> > using the following
> > 
> > > +administrative commands:
> > 
> > administration not administrative
> > 
> Ack.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

