Return-Path: virtio-comment-return-1508-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <3b0fd676eed3baa775009a17047737dbe669594c.1604992813.git.jie.deng@intel.com>
 <83052aa7-8815-ce9d-3c9f-59d863107702@redhat.com>
 <20201110053225-mutt-send-email-mst@kernel.org>
 <5a0fcb8b-80a1-d1e0-5d9f-2f6cc003adc2@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <616323bf-25a5-d951-cd4c-3d67f08f5af8@intel.com>
Date: Thu, 12 Nov 2020 09:51:17 +0800
MIME-Version: 1.0
In-Reply-To: <5a0fcb8b-80a1-d1e0-5d9f-2f6cc003adc2@redhat.com>
Subject: Re: [virtio-comment] [PATCH v4] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/11/10 18:59, Paolo Bonzini wrote:
> On 10/11/20 11:33, Michael S. Tsirkin wrote:
>>> Sorry I didn't reply last week, but I really would prefer if virtio-i2c
>>> supported write-read transactions.
>>
>> And I think an easier way is to allow multi-segment transactions
>> probably using the stop flag.
>
> You cannot always be sure that the host would support them (with the 
> exception of write+read transactions, which are pretty much 
> universal), so you would also need to describe what the host features 
> are.
>
> Paolo
>
Then I will send v5 to support write+read transactions using Paolo's 
proposal.
I think we may have a simple version merged first and then improve it 
according
to the actual needs.

Thank you.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

