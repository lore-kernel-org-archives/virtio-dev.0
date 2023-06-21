Return-Path: <virtio-dev-return-13018-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306DFEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:43:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7516579124
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:43:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BA4C9865C9
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:43:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 444DC9865BD; Wed, 21 Jun 2023 19:43:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 312009865C1
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 19:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NG747bzXPP2Q94-kJhV-rw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376597; x=1689968597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGRpEQ2zm9t7hGlql6y88PzuQjR6iy448rC6ShTNhKA=;
        b=KpWqu7jZtKbvFVJou9+uy4csSPWzha4LY02+eWnpMI/YrpAwfzZ+vD/1xKfr6ilCka
         NV8yon3oFX/aqx3cUZg+cwSGhtLWmToSMacXUcqw/bXJmMkKbeGCxeEiNsAumzOe4YNx
         CSSimpj/ZzHeGs0Pg5VrnT8Dv5ajXxPPRx+hT3gJ45jod3UC2Zb2Cw3+S0nVm032+soj
         AHvjo4wa6h9Ca0NZ8ia3FdHySUSpwOQD6LJaWyYQD0ZJTF0tpaz2TfNrbDqAXvr38FiX
         2UrLJnhsee2N43mmlJaCkH36/KNSzyI/y1rWnNnyEWiAScIHio/nHhU6qIPPR6/76x/X
         p7LQ==
X-Gm-Message-State: AC+VfDysNg139CVRQoTP73x43PKmZcq/IuVK8f/p9HNvGpak0ErorEN+
	jsZ3q4AVYRqYvihQj+czOsY8FVfN1TAB1+2IF3hXqTON75qXauT5ig/Fv2/7Qw9q/WahOx8fErO
	GJV9/eVVRzzJedMfLKHRWE+HNtuj+
X-Received: by 2002:a17:907:971f:b0:989:2264:fa86 with SMTP id jg31-20020a170907971f00b009892264fa86mr5081818ejc.17.1687376596884;
        Wed, 21 Jun 2023 12:43:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4L6NMg3wiMuPJx7tfoU1+o9QBDlS7po1wKk1aySX2GC5ZtS9nSqLVXviiSd2bF4oQwaord1g==
X-Received: by 2002:a17:907:971f:b0:989:2264:fa86 with SMTP id jg31-20020a170907971f00b009892264fa86mr5081813ejc.17.1687376596569;
        Wed, 21 Jun 2023 12:43:16 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:43:12 -0400
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
Message-ID: <20230621153559-mutt-send-email-mst@kernel.org>
References: <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619134649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54815F1345502771D9FE24CEDC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54812103E5CB5CF860B9B50CDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621115131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F5232331A63C138F8754DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F5232331A63C138F8754DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access

On Wed, Jun 21, 2023 at 04:01:00PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 21, 2023 11:56 AM
> 
> > Not like v3 please. If you want to re-open this:
> > 
> > 
> > First I think we need multiple offsets just like notification capaiblity, sorted by
> > priority. Second I think we need ability to report offset within owner not
> > member.
> >
> > So please add ability to report multiple offsets, and add e.g.
> > a flags field, with bits for owner, member.
> 
> What are these multiple offsets for?

Different BARs.  For example, IO versus memory. Yes I know VFs don't
support IO but PFs do. prefetch vs non-prefetch might matter too
(non-prefetch is mostly limited to 32 bit).


> Do you mean two offsets? One for owner and one for member?
> Both bits are optional. Do you agree? 

I agree that everything should be optional sure. Let's not limit it to
two though.  There could be multiple BARs or whatever. We have ability
to pass buffers of arbitrary length and device reports the length.
Maybe have a SHOULD recommending not more than 10 of these (1 for each
possible PCI BAR one for each possible VF BAR).

This is to match the functionality that notification capability has.



> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

