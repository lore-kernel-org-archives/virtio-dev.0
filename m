Return-Path: virtio-comment-return-1494-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <61930337391bdfd23ed164288d998c04177bc839.1603435652.git.jie.deng@intel.com>
 <20201023115932-mutt-send-email-mst@kernel.org>
 <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
 <20201027071957-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0a26ef6-09a7-9cb3-73d3-b68a22cfee28@redhat.com>
Date: Sat, 31 Oct 2020 14:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <20201027071957-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v2] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 27/10/20 12:20, Michael S. Tsirkin wrote:
>> The I2C doesn't support segments numbering and sorting.
>> So if one creates a multi-segment transaction, then he/she should keep the
>> segments in order.
>>
>> Thanks.
> Fine, but I see no flags to signal start/end of such a transaction.
> 

In theory there's no difference between one multi-segment transaction
and many single-segment transactions _in a single-master scenario_.

However, it is a plausible configuration to have multiple guests sharing
an I2C host device as if they were multiple master.

For this reason, I would prefer to have at least support for
transactions with 1 write and 1 read segment to the same address (see my
other message).

Paolo


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

