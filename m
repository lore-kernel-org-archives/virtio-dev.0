Return-Path: virtio-return-3062-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 00:11:26 +0200
In-Reply-To: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
Message-Id: <1523398287-25480-3-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [RFC PATCH 2/3] notifications:notifications as basic virtio facility
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Let's introduce notifications as basic virtio facility early on. This
shall not only increase the cohesion between core and transport
description by having a well-defined  place where notifications are
introduced, but also give us the opportunity to explain some
discrepancies.

Namely notifications send by the device to the driver were often called
interrupts prior v1.1. Getting completely rid of that terminology is
however not viable in case of some names.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 content.tex |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/content.tex b/content.tex
index 4ccb823..87cc0e2 100644
--- a/content.tex
+++ b/content.tex
@@ -8,6 +8,7 @@ device consists of the following parts:
 \begin{itemize}
 \item Device status field
 \item Feature bits
+\item Notifications
 \item Device Configuration space
 \item One or more virtqueues
 \end{itemize}
@@ -150,6 +151,36 @@ requirements documented within these legacy interface sections.
 Specification text within these sections generally does not apply
 to non-transitional devices.
 
+\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
+/ Notifications}
+
+The notion of sending a notification (driver to device or device
+to driver) plays an important role in this specification. The
+modus operandi of the notifications is transport specific.
+
+There are three types of notifications: 
+\begin{itemize}
+\item device configuration space notification
+\item available buffers notification
+\item used buffer notifications. 
+\end{itemize}
+
+The recipient of device configuration space notifications and use buffer
+notifications is the driver. These indicate that a configuration space
+has changed and that a buffer may have been made used on a virtqueue
+(designated by the notification) respectively. The recipient of available
+buffers notifications is the device. Such notifications indicates that a
+buffer may have been made available on a virtqueue (designated by the
+notification). The semantic as well as other important aspects  of the
+notifications is specified in detail in the following chapters.
+
+Most transports implement notifications sent by the device to the
+driver using interrupts. Due to this in previous versions of this
+specification, these notifications were often called interrupts.
+Some names defined in this specification still retain this interrupt
+terminology. Occasionally we also use the term event to refer to
+a notification or a receipt of a notification.
+
 \section{Device Configuration Space}\label{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
 
 Device configuration space is generally used for rarely-changing or
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

