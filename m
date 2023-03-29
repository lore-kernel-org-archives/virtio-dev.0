Return-Path: <virtio-dev-return-11839-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E8DC74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:16:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08A22157EE7
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:16:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02D109864BA
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 13:16:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED4529864A3; Wed, 29 Mar 2023 13:16:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB9D59864A4
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Mar 2023 13:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6e5ldR8pN6WbKVIzZHtWgQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
In-Reply-To: <PH0PR12MB5481430027FD045C5F78EFD9DC899@PH0PR12MB5481.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-4-parav@nvidia.com> <87tty3ncjj.fsf@redhat.com>
 <PH0PR12MB5481430027FD045C5F78EFD9DC899@PH0PR12MB5481.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 29 Mar 2023 15:16:26 +0200
Message-ID: <87ilejn1ed.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] RE: [PATCH v9 3/8] transport-mmio: Rename QueueNum register

On Wed, Mar 29 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Wednesday, March 29, 2023 5:16 AM
>> 
>> I'm not sure it is worthwile keeping the lines short so aggressively (after all, it
>> does not affect the generated html/pdf), especially as it makes the diff a bit
>> harder to read, but I don't have a strong objection to it.
>>
> I agree, 80 or 100 characters should be reasonable based on Linux kernel experience.
>
> The short line requirement came from [1].
> Shall I change [1] to 80 characters?
>
> [1] https://github.com/oasis-tcs/virtio-spec/blob/b0414098602fbdb0bc5efa4ff06ea6cae8123ed4/_vimrc#L5

I wasn't even aware of that file, as I don't use vim... in any case, 65
seems way too short, especially as many (most?) lines are already longer
than that. 80 (or 100) seems more reasonable.

Michael, do you remember where the 65 came from? Is that anything we
still care about?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

