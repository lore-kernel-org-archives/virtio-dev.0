Return-Path: <virtio-dev-return-11312-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09AC49863FE
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 08:59:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230225181618-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225181618-mutt-send-email-mst@kernel.org>
Date: Mon, 27 Feb 2023 09:59:07 +0100
Message-ID: <877cw35vs4.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH 0/3] Cleanup for PCI transitional common cfg
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Feb 25 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sun, Feb 26, 2023 at 12:29:58AM +0200, Parav Pandit wrote:
>> Legacy interface PCI Device layout description has following issues.
>> 
>> 1. repeated 'structure' word
>> 2. virtio header was defined the 0.9.5 spec. It is referred with
>>    different keywards in this section with multiple different words
>>    as (a) virtio header, (b) general headers, (c) legacy configuration
>>    structure, (d) virtio common configuration structure and
>>    (e) other fields.
>> 3. Driver and device requirements listing is intermixed.
>> 4. spelling error of structure
>> 5. Legacy interface common configuration requirements are not adjacent
>>    to 1.x comm
>> 
>> Hence, this short series overcomes above issues.
>
> Looking at the patchset so far I'm inclined to say - leave
> legacy well alone. This is not an improvement.
>
> Gratituis changes for trivial benefit have a cost - people have to
> re-read spec this to see what changed.  Making things significantly
> easier for new readers would make it worth it.  As it stands - this is
> not worth it.

I think I agree.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

