Return-Path: <virtio-dev-return-13266-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467AEEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:47:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7B2522A82C
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:47:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6841E98680B
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:47:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A75F986728; Thu,  6 Jul 2023 16:47:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48CC5986729
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 16:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LzIesjZwOfqkqyJI2wcGJg-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 06 Jul 2023 18:47:29 +0200
Message-ID: <87leftugv2.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Thursday, July 6, 2023 12:28 PM
>> 
>> On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> > diff --git a/transport-pci-legacy-regs.tex
>> > b/transport-pci-legacy-regs.tex new file mode 100644 index
>> > 0000000..ceea28c
>> > --- /dev/null
>> > +++ b/transport-pci-legacy-regs.tex
>> > @@ -0,0 +1,42 @@
>> > +\subsection{Legacy Interface: Group member device Configuration
>> > +Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI
>> > +Bus / Legacy Interface: Group Member Device Configuration Region
>> > +Access}
>> > +
>> > +The PCI owner device or the member device or both support driver
>> > +notifications using
>> 
>> What about
>> 
>> "The PCI owner device, the member device, or both can choose to support..." ?
>>
> Fine too.
> Any thing wrong in having or as above, so I don't write it next time?
> Or that in current form reads better to me.

Just a bare "support" does not really tell the reader if this is
something that is required or optional. Dropping the first "or" makes it
read better for me.

>  
>> > +a notification region defined in \field{struct
>> virtio_pci_legacy_notify_region}.

(...)

>> > +The group owner device or the group member device or both MAY support
>> > +driver notifications region.
>> 
>> Make this "a driver notification region"?
>>
> Notifications are generally more than one and spec has the section "driver notifications", so...

I'd parse this as "a region for the purpose of notification" (and
"notification region" is used above)... but in any case, we need the
article here, I think.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

