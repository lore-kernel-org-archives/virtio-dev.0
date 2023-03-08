Return-Path: <virtio-dev-return-11532-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9540C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:43:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3EBE842B65
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:43:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34F0E9866F1
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:43:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1E9B99866F0; Wed,  8 Mar 2023 14:43:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 081339866EF
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 14:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8vkuEBy9NdOQiQ5Jp7c82A-1
From: Cornelia Huck <cohuck@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Parav Pandit <parav@nvidia.com>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com"
 <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>,
 "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
 <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <992e9a1e-3799-842c-79f3-e66f5c823356@nvidia.com>
Organization: Red Hat GmbH
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
 <20230303081900-mutt-send-email-mst@kernel.org>
 <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
 <20230307192752-mutt-send-email-mst@kernel.org>
 <6668fd7a-3eb3-0447-9cbf-72d308b1336a@nvidia.com>
 <20230308070531-mutt-send-email-mst@kernel.org>
 <992e9a1e-3799-842c-79f3-e66f5c823356@nvidia.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 08 Mar 2023 15:43:14 +0100
Message-ID: <87cz5jl2wt.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

On Wed, Mar 08 2023, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 08/03/2023 14:07, Michael S. Tsirkin wrote:
>> On Wed, Mar 08, 2023 at 12:55:37PM +0200, Max Gurtovoy wrote:
>>>>> 5. VIRTIO_ADMIN_STATUS_COMMAND_SPECIFIC_ERR (for more info read the
>>>>> command_specific_error field).
>>>>
>>>> I don't think it's a good idea, we'll have to agree to disagree.
>>>
>>> Ok.
>>> can you explain why isn't this a good idea please ?
>> 
>> Pointless complexity for spec, devices and drivers. In the end drivers
>> don't really do anything with all this detailed info.
>> 
>
> Pointless according to your own opinion. As I mentioned, other 
> specifications and devices work this way. I didn't invent it.
>
> All drivers in SW world ? All drivers in Linux ? or Virtio drivers ?

FWIW, I've spent enough time translating
detailed-but-not-really-that-useful error status codes to -EINVAL for
s390-specific things...

The only thing that might make sense to transmit to a consumer would be
the difference between "this thing won't work" and "this thing might
work if you retry later" (if the consumer is even in a place to retry.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

