Return-Path: <virtio-dev-return-10218-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B15309864B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 Nov 2022 09:53:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221122141829-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-10-mst@redhat.com> <87tu2rdleb.fsf@redhat.com>
 <20221122141829-mutt-send-email-mst@kernel.org>
Date: Wed, 23 Nov 2022 10:52:59 +0100
Message-ID: <87edtungjo.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v8 9/9] admin: conformance clauses
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 22, 2022 at 05:06:04PM +0100, Cornelia Huck wrote:
>> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > +List of supported commands MUST NOT change: after reporting a
>> 
>> s/List/The list/
>> 
>> > +given command as supported through VIRTIO_ADMIN_CMD_LIST_QUERY
>> > +device MUST NOT later report it as unsupported.
>> 
>> s/device/the device/
>> 
>> Is that for multiple queries while the device is alive? Is the device
>> allowed to report a different list of commands after it has been reset?
>> And is it allowed to _add_ commands?
>
> I feel it's a bad idea to allow this to change even across resets, at
> least until we have a usecase where it's neeed. Basically
> same as with features. Will document.

Ok.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

