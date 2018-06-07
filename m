Return-Path: virtio-dev-return-4297-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E956B581919C
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Jun 2018 22:25:43 -0700 (PDT)
Message-ID: <5B18C2B2.30709@intel.com>
Date: Thu, 07 Jun 2018 13:29:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com> <1524550428-27173-5-git-send-email-wei.w.wang@intel.com> <20180606064315.GB7815@xz-mi> <5B17B366.5030802@intel.com> <20180607031732.GG7815@xz-mi>
In-Reply-To: <20180607031732.GG7815@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/07/2018 11:17 AM, Peter Xu wrote:
> On Wed, Jun 06, 2018 at 06:11:50PM +0800, Wei Wang wrote:
>
> I got similar comments from Michael, and it will be
> while (1) {
> lock;
> func();
> unlock();
> }
>
> All the unlock inside the body will be gone.
> Ok I think I have more question on this part...
>
> Actually AFAICT this new feature uses iothread in a way very similar
> to the block layer, so I digged a bit on how block layer used the
> iothreads.  I see that the block code is using something like
> virtio_queue_aio_set_host_notifier_handler() to hook up the
> iothread/aiocontext and the ioeventfd, however here you are manually
> creating one QEMUBH and bound that to the new context.  Should you
> also use something like the block layer?  Then IMHO you can avoid
> using a busy loop there (assuming the performance does not really
> matter that much here for page hintings), and all the packet handling
> can again be based on interrupts from the guest (ioeventfd).
>
> [1]

Also mentioned in another discussion thread that it's better to not let 
guest send notifications. Otherwise, we would have used the virtqueue 
door bell to notify host.
So we need to use polling here, and Michael suggested to implemented in 
BH, which sounds good to me.


>
>>> [...]
>>>> +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>>>> +    .name = "virtio-balloon-device/free-page-report",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = virtio_balloon_free_page_support,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>>> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
>>> (could we move all the poison-related lines into another patch or
>>>    postpone?  after all we don't support it yet, do we?)
>>>
>>   We don't support migrating poison value, but guest maybe use it, so we are
>> actually disabling this feature in that case. Probably good to leave the
>> code together to handle that case.
> Could we just avoid declaring that feature bit in emulation code
> completely?  I mean, we support VIRTIO_BALLOON_F_FREE_PAGE_HINT first
> as the first step (as you mentioned in commit message, the POISON is a
> TODO).  Then when you really want to completely support the POISON
> bit, you can put all that into a separate patch.  Would that work?
>

Not really. The F_PAGE_POISON isn't a feature configured via QEMU cmd 
line like F_FREE_PAGE_HINT. We always set F_PAGE_POISON if 
F_FREE_PAGE_HINT is enabled. It is used to detect if the guest is using 
page poison.


>>
>>>> +    if (virtio_has_feature(s->host_features,
>>>> +                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>>> +        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
>>>> +        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>>> +        s->free_page_report_cmd_id =
>>>> +                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN - 1;
>>> Why explicitly -1?  I thought ID_MIN would be fine too?
>> Yes, that will also be fine. Since we states that the cmd id will be from
>> [MIN, MAX], and we make s->free_page_report_cmd_id++ in start(), using
>> VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN here will make it [MIN + 1, MAX].
> Then I would prefer we just use the MIN value, otherwise IMO we'd
> better have a comment mentioning about why that -1 is there.

Sure, we can do that.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

