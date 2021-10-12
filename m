Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 0/2] virtio: i2c: Allow zero-length transactions
Date: Tue, 12 Oct 2021 16:53:36 +0530
Message-Id: <cover.1634037711.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

Arnd suggested (over IRC) to split this into two patches for better readability
and so here is a resend. The eventual specification hasn't changed at all.

V4->V5:
- Split into two patches.

V3->V4:
- Add a new mandatory feature flag.

V2->V3:
- Add conformance clauses that require that the flag is consistent with the
  buffer.

V1->V2:
- Name the buffer-less request as zero-length request.

------

I did try to follow the discussion you guys had during V4, where we added
support for multiple buffers for the same request, which I think is unnecessary
now, after introduction of the VIRTIO_I2C_FLAGS_FAIL_NEXT flag.

https://lists.oasis-open.org/archives/virtio-comment/202011/msg00005.html

And so starting this discussion again, because we need to support stuff
like: i2cdetect -q <i2c-bus-number>, which issues a zero-length SMBus
Quick command.

Viresh Kumar (2):
  virtio: i2c: No need to have separate read-write buffers
  virtio: i2c: Allow zero-length transactions

 virtio-i2c.tex | 76 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 31 deletions(-)

-- 
2.31.1.272.g89b43f80a514

