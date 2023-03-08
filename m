Return-Path: <virtio-dev-return-11503-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7D7C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:07:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 39C6C3E306
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:07:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A3C59866EA
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 10:07:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 082E99866E6; Wed,  8 Mar 2023 10:07:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAF7A9866E8
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 10:07:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NcxWmMV_OeygkAK6ne9UnA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <PH0PR12MB548186EADD442CF688EA21BEDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230217154529.33508-1-parav@nvidia.com>
 <PH0PR12MB5481865B12E7B23862B0F140DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <875ybej6hb.fsf@redhat.com>
 <PH0PR12MB548186EADD442CF688EA21BEDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 08 Mar 2023 11:07:48 +0100
Message-ID: <87lek7lfnv.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v3 0/2] virtio-net: Improve dev
 config layout

On Tue, Mar 07 2023, Parav Pandit <parav@nvidia.com> wrote:

> Hi Cornelia,
>
>> -----Original Message-----
>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Monday, March 6, 2023 9:32 AM
>> To: Parav Pandit <parav@nvidia.com>; mst@redhat.com; virtio-dev@lists.oasis-
>> open.org
>> Cc: virtio-comment@lists.oasis-open.org; Shahaf Shuler <shahafs@nvidia.com>
>> Subject: RE: [PATCH v3 0/2] virtio-net: Improve dev config layout
>> 
>> On Tue, Feb 21 2023, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> >> From: Parav Pandit <parav@nvidia.com>
>> >> Sent: Friday, February 17, 2023 10:45 AM
>> >
>> >> Patch summary:
>> >> patch-1: consolidate read only field at one place in driver
>> >> requirements
>> >> patch-2: define device configuration layout before describing its fields.
>> >>
>> >> changelog:
>> >> v2->v3:
>> >> - split into two patches
>> >> - move read only description to driver requirements section
>> >
>> > These 2 patches are reviewed.
>> > Can you please open a ballot for it?
>> > Github issue:
>> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00405.html
>> > And the github description has the latest link this time. :)
>> 
>> I think something went wrong here... the link above points to this series (i.e. not
>> the latest one), and so does the github issue, and therefore the ballot. I think we
>> should withdraw the ballot?
>
> Please withdraw.
>
> Right link is: [1].
> Please create the new ballot with link [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00556.html

Done.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

