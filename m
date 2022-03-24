Return-Path: <virtio-return-3652-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220324080218-mutt-send-email-mst@kernel.org>
References: <20220324103412.2740-1-mst@redhat.com>
 <87y20z61ck.fsf@redhat.com>
 <20220324080218-mutt-send-email-mst@kernel.org>
Date: Thu, 24 Mar 2022 13:24:09 +0100
Message-ID: <87r16r5yja.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-dev] [PATCH] packed-ring: fix some typos
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Mar 24, 2022 at 12:23:23PM +0100, Cornelia Huck wrote:
>> On Thu, Mar 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > flag is misnamed in a couple of places.
>> 
>> s//The VIRTQ_DESC_F_INDIRECT_FLAG /
>
> You mean VIRTQ_DESC_F_INDIRECT don't you?

Typo corrected by another typo... yeah.

>
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> >  packed-ring.tex | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

