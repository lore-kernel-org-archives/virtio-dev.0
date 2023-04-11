Return-Path: <virtio-dev-return-12111-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E372C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:56:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E621819091E
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:56:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDB9F9864B3
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 08:56:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D02CB983DFF; Tue, 11 Apr 2023 08:56:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8FC0986371
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 08:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ze2Z95ZOPC-tnae-9RQprg-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <20230407073308-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405012723-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405172731.561890b1.pasic@linux.ibm.com>
 <PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407073308-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 11 Apr 2023 10:56:08 +0200
Message-ID: <87ile2kdav.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [PATCH v12 03/10]
 content: Rename confusing queue_notify_data and vqn names

On Fri, Apr 07 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 05, 2023 at 03:58:55PM +0000, Parav Pandit wrote:
>> For sure "cookie" is better than "config_data" and I don't have objection to "cookie".
>> 
>> But I disagree to the claim that "identifier" is less good than "cookie".
>> 
>> It is pointless debate of "identifier" vs "cookie".
>> 
>> The union format is very useful to describe this crisply, I will use it.
>
> I guess I'm fine with "cookie" in that in CS it is by now widely
> understood to mean "some opaque data".
> identifier comes from "identical", so implies a 1:1 mapping IMO.

Agreed, a "cookie" is not the same as an "identifier", although it may
contain one.

>
>
> The logic behind using a cookie is that it's a bit similar
> to host cookie from ccw.
> However, with ccw host cookie is used unconditionally, as
> opposed to depending on the flag.
>
>
>
>> Do you prefer to rename F_CONFIG_DATA To F_CONFIG_COOKIE?
>
> It should all be consistent, but I worry about ccw which uses cookies
> unconditionally. I am fine with leaving it as F_CONFIG_DATA for now
> unless we see a good way to avoid confusion for ccw.

Yes, please leave it as F_CONFIG_DATA, as we're just putting some "data"
there in the end (and F_CONFIG_COOKIE might indeed be confusing for the
ccw case.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

