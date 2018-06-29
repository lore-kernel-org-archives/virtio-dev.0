Return-Path: virtio-dev-return-4608-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 692AD5818F8A
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jun 2018 08:29:10 -0700 (PDT)
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
 <20180629172216-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <909d0983-bb54-25bb-03f5-7a28ded76500@redhat.com>
Date: Fri, 29 Jun 2018 17:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180629172216-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

>> And looking at all the discussions and problems that already happened
>> during the development of this series, I think we should rather look
>> into how clean free page hinting might solve the same problem.
> 
> I'm not sure I follow the logic. We found that neat tricks
> especially re-using the max order free page for reporting.

Let me rephrase: history of this series showed that this is some really
complicated stuff. I am asking if this complexity is actually necessary.

No question that we had a very valuable outcome so far (that especially
is also relevant for other projects like Nitesh's proposal - talking
about virtio requests and locking).

> 
>> If it can't be solved using free page hinting, fair enough.
> 
> I suspect Nitesh will need to find a way not to have mm code
> call out to random drivers or subsystems before that code
> is acceptable.
> 
> 


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

