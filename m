Return-Path: <jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 0/2] Vitqueue State Synchronization
Date: Tue,  6 Jul 2021 12:33:32 +0800
Message-Id: <20210706043334.36359-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: mst@redhat.com, jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi All:

This is an updated version to implement virtqueue state
synchronization which is a must for the migration support.

The first patch introduces virtqueue states as a new basic facility of
the virtio device. This is used by the driver to save and restore
virtqueue state. The states were split into available state and used
state to ease the transport specific implementation. It is also
allowed for the device to have its own device specific way to save and
resotre extra virtqueue states like in flight request.

The second patch introduce a new status bit STOP. This bit is used for
the driver to stop the device. The major difference from reset is that
STOP must preserve all the virtqueue state plus the device state.

A driver can then:

- Get the virtqueue state if STOP status bit is set
- Set the virtqueue state after FEATURE_OK but before DRIVER_OK

Device specific state synchronization could be built on top.

Please review.

Thanks

Changes from V1:

- introduce used_idx for synchronize used state for split virtqueue,
  this is needed since the used ring is read only by the driver.
- stick to the uni-directional state machine, this means driver is
  forbidden to clear STOP, the only way to 'resume' the device is to
  reset and re-initialization the device. This simplify the
  implementation and make it works more like a vhost device.
- mandate the virtqueue state setting during device initialization
- clarify the steps that are required for saving the virtqueue state
- allow the device to have its specifc way to save and restore extra
  virtqueue state
- rename DEVICE_STOPPED to STOP
- various other tweaks

Jason Wang (2):
  virtio: introduce virtqueue state as basic facility
  virtio: introduce STOP status bit

 content.tex | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

-- 
2.25.1

