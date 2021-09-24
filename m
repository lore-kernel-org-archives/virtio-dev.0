Return-Path: <virtio-dev-return-8708-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1685C986429
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Sep 2021 13:50:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <291795BE-C269-42C9-84E8-74D5CDE59704@bytedance.com>
References: <20210903080303.39915-1-weijunji@bytedance.com>
 <87czp0g88j.fsf@redhat.com>
 <291795BE-C269-42C9-84E8-74D5CDE59704@bytedance.com>
Date: Fri, 24 Sep 2021 15:50:07 +0200
Message-ID: <87czoydqwg.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] Reserve device id for RDMA device
Content-Type: text/plain
To: Junji Wei <weijunji@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com, Hannes Reinecke <hare@suse.de>, Yongji Xie <xieyongji@bytedance.com>, =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, dingtao.darren@bytedance.com, duanxiongchun@bytedance.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 23 2021, Junji Wei <weijunji@bytedance.com> wrote:

>> On Sep 22, 2021, at 7:28 PM, Cornelia Huck <cohuck@redhat.com> wrote:
>> 
>> On Fri, Sep 03 2021, Junji Wei <weijunji@bytedance.com> wrote:
>> 
>>> Use device ID 42
>>> 
>>> Signed-off-by: Junji Wei <weijunji@bytedance.com>
>>> ---
>>> content.tex | 2 ++
>>> 1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/content.tex b/content.tex
>>> index 3aeb4a4..b57c997 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -2878,6 +2878,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>> \hline
>>> 41         &   GPIO device \\
>>> \hline
>>> +42         &   RDMA device \\
>>> +\hline
>>> \end{tabular}
>>> 
>>> Some of the devices above are unspecified by this document,
>> 
>> Do we have an answer to the issues raised with the QEMU patches? IOW, is
>
> Yes.
>
>> it reasonable to expect that we can actually implement a usuable RDMA
>> device? While device IDs are generally cheap, it would be good not to
>> have too many dead entries.
>
> I think we can implement an usable RDMA device through uRDMA (a
> software implementation of the RoCEv2 protocol in QEMU with VFIO
> or DPDK).

If nobody disagrees, we can start a vote.

One last question: there were two patches, this one and the one linked
in the issue... I think they are the same, right? (I do not trust myself
on Friday afternoons.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

