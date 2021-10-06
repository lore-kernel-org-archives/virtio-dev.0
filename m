Return-Path: <virtio-dev-return-8795-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81295986495
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Oct 2021 10:17:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CAM9Jb+jtYgyPrgVaHV-c5PPE8yLoJKhU-r+XWYx6qruMrmEgiA@mail.gmail.com>
References: <20211006062157.21768-1-pankaj.gupta.linux@gmail.com>
 <874k9u1vf5.fsf@redhat.com>
 <CAM9Jb+h130AAJRMNz1rEuKSXeOjtyR=oi23KMr+w4GQPhRwuQg@mail.gmail.com>
 <87y276zh3p.fsf@redhat.com>
 <CAM9Jb+jtYgyPrgVaHV-c5PPE8yLoJKhU-r+XWYx6qruMrmEgiA@mail.gmail.com>
Date: Wed, 06 Oct 2021 12:17:25 +0200
Message-ID: <87pmsizccq.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v5] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 06 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

>> >> > +\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
>> >> > +For SHARED mappings, for the workload is a single application inside
>> >> > +the driver and there is no risk in sharing data. Device sharing
>> >>
>> >> Sorry for noticing this only now, but I have trouble parsing this
>> >> sentence. Does it mean that you can use SHARED mapping if the workload
>> >> is a single application?
>> >
>> > yes and if risk in sharing data is very less or acceptable.
>> >
>> >>
>> >> > +same backing region with SHARED mapping can be used as a valid configuration.
>>
>> Hm... maybe rephrase this paragraph as:
>>
>> "When using SHARED mappings with a workload that is a single application
>> inside the driver where the risk in sharing data is very low or
>> nonexisting, the device sharing the same backing region with a SHARED
>> mapping can be used as a valid configuration."
>
> Thank you Cornelia!
> I tried to reread my initial statement and I think that also precisely conveys
> the use-case.
>
> If you are okay, I will respin v6 with only space with bracket change
> and Stefan r-o-b?

And my proposed change? If nobody else has a comment, I think we could
start voting on that.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

