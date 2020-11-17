Return-Path: virtio-comment-return-1521-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <3b0fd676eed3baa775009a17047737dbe669594c.1604992813.git.jie.deng@intel.com>
 <83052aa7-8815-ce9d-3c9f-59d863107702@redhat.com>
 <20201110053225-mutt-send-email-mst@kernel.org>
 <5a0fcb8b-80a1-d1e0-5d9f-2f6cc003adc2@redhat.com>
 <616323bf-25a5-d951-cd4c-3d67f08f5af8@intel.com>
 <20201112035331-mutt-send-email-mst@kernel.org>
 <c5d080c1-5dcf-cc80-681c-5dae34797e9e@intel.com>
 <ba89c7cc-fad4-e0ca-642a-220364ffd05a@intel.com>
 <e79f44b9-8620-3635-1f60-90a4c6dd4e2e@redhat.com>
 <0a821501-ce4b-6491-c9ad-654e91c99d93@intel.com>
 <20201117082342.kcbqq3bcysdb26ko@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5eec4f47-9815-0c11-4c85-a05a68995880@redhat.com>
Date: Tue, 17 Nov 2020 16:59:34 +0100
MIME-Version: 1.0
In-Reply-To: <20201117082342.kcbqq3bcysdb26ko@sirius.home.kraxel.org>
Subject: Re: [virtio-comment] [PATCH v4] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>, Jie Deng <jie.deng@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, yu1.wang@intel.com, conghui.chen@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 17/11/20 09:23, Gerd Hoffmann wrote:
> That is not enough.  You also need that for the transactions.  If the
> driver sends a write and a read message the device needs to know
> whenever that is one or two transactions.  So if you want continue
> with the i2c_msg list idea you need some way to group your messages
> into transactions.
> 
> Or you go with paolos idea which looks simpler to me.

Yeah, that seems the simplest.  You can also add a flags u32 that must 
be zero, in order to simplify future extensibility.

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

