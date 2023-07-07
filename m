Return-Path: <virtio-dev-return-13304-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F33EB64DA
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:12:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 576362ACB1
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:12:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EBCA986811
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:12:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 30999984091; Fri,  7 Jul 2023 08:12:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FD549867F9
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 08:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: o35KKrr4OWeZi-3xe7xDGw-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
 <david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "sburla@marvell.com"
 <sburla@marvell.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Yishai
 Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf
 Shuler <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB54814132C3C74F00CD6F399BDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230706135858-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706144427-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706145538-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706154002-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AF3000FFDBA2CBA5D7ADDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706162505-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B7E0DE415B1489818DE9DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706164028-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814132C3C74F00CD6F399BDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 07 Jul 2023 10:12:35 +0200
Message-ID: <87v8ew16oc.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v10 4/4] transport-pci: Introduce
 group legacy group member config region access

On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Thursday, July 6, 2023 4:42 PM
>
> [..]
>> > Can we please avoid this over engineering?
>> > Interface has the doors open for driver to make wise decision depending on
>> its environment.
>> 
>> what if driver can access both with the same ease? this is the case that bothers
>> me and I think it's practical since it will be common on linux.
>
> Then Linux can say my preference is order, so it picks member.

Let's step back and consider what our goal is here: to provide a spec
that someone wanting to implement a driver can follow and end up with a
driver that works with devices that adhere to this spec.

I don't think expecting the driver to make "wise descisions" is helpful
for the person wanting to implement a driver. "Do this, and in case this
does not work in your environment, do that" seems much more helpful, and
still gives enough flexibility to cover different environments. In
short, make things simple for the consumer of the spec.

[Also, I notice that the discussion seems to get bogged down in tiny
details, fundamental statements, or a mixture of both. It might
sometimes be helpful to just step back, re-read the original proposal,
and only then answer. Otherwise, this leads to frustration for everyone
involved.]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

