Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] virtio-gpio: Specify character encoding for gpio names
Date: Thu, 19 Aug 2021 09:26:54 +0530
Message-Id: <8cb679e3013bc9dd49af5d4837c0dcffeb41b8e8.1629345350.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Specify 7-bit ASCII character encoding for GPIO names strings.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/115
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Use ASCII instead of UTF-8.

 virtio-gpio.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virtio-gpio.tex b/virtio-gpio.tex
index 5da16d920aa3..3c614ec97b92 100644
--- a/virtio-gpio.tex
+++ b/virtio-gpio.tex
@@ -119,7 +119,8 @@ \subsubsection{requestq Operation: Get Line Names}\label{sec:Device Types / GPIO
 order of the GPIO line numbers. The names of the GPIO lines are optional and may
 be present only for a subset of GPIO lines. If missing, then a zero-byte must be
 present for the GPIO line. If present, the name string must be zero-terminated
-and the name must be unique within a GPIO Device.
+and the name must be unique within a GPIO Device. The names of the GPIO lines
+are encoded in 7-bit ASCII.
 
 These names of the GPIO lines should be most meaningful producer names for the
 system, such as name indicating the usage. For example "MMC-CD", "Red LED Vdd"
-- 
2.31.1.272.g89b43f80a514

