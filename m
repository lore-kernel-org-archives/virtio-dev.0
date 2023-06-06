Return-Path: <virtio-dev-return-12871-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5C1C77B7A
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 26A0429FC5
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2207498667B
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:15:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1561F98658B; Tue,  6 Jun 2023 20:15:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5A0298681E;
	Tue,  6 Jun 2023 20:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvFLTH5u27t8uqf5m/YWZ2yRnY8fMQ6eiqYEUYLNElYnpbreQi+znSewdvR3QT5IDn3FgPtTuJ1ioTIAm3gayfSHu8tTSOLB9Qb1EkqjQtdE7/jAUIfjX94iJ1RCUEvNPPNrs5tkoJ3A9oq9GI9THFM670MHb+dXMDijpSzq1mm/GC9HYhSUgB7PCk8UXb4O50PMlo0pKDV262H95qOcxFRY4tVd7m7XiXvkQ75IrZfaQ0dc5vM/H/fM/5CCscNnPQwzGKXrcmwM0VLTJrltAMjA38B9TjOjr8VkaTxSt/c+AywYqx53a4gLaUmbHpQvckKK2eiWrwRjfXwz6TqNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe0hYN61RuBFvbDOMnrbkw0mhoyBfU8kR8cRJazOmxM=;
 b=RTb1bMDqNDOPSw3LI7+aMkzGmJ/abxjthsmEbqiTmLd+Udly2TWd2Ui9W48OE7jP2k+2ih97D+IZWLZII/gD3dnYpnWTYIHOE43MAJ/2hvlFCIvU3CiBLqt3W31iXBgteVuCQtLc70yN6vZESC/UfgLRrIno8zFsxj+Fsd0ZIN4O1WQv+rPhVALeUcCIaQ5ufYMp9pO4rw/rHMiaOVRmteqOzKyBw2tGBRaKn7N2gCOEdN8j/MqJgFxcxzf4u/NfSB+lkLQnoz3nc02D1DnJ+dBcLo/83CGOsFZK74LTUAF9f8YedgE24/MKaYECst/j8GtRGaUJSRJ8vFJM/Fo3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.oasis-open.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <virtio-comment@lists.oasis-open.org>, <mst@redhat.com>,
	<cohuck@redhat.com>, <david.edmondson@oracle.com>
CC: <virtio-dev@lists.oasis-open.org>, <sburla@marvell.com>,
	<jasowang@redhat.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 6 Jun 2023 23:15:15 +0300
Message-ID: <20230606201515.775121-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230606201515.775121-1-parav@nvidia.com>
References: <20230606201515.775121-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: e3278b62-aa0c-4ab5-b491-08db66cad06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cEQgNGuyyY7iVKoNtf7OoGe4Rgr8C5SAS1YYXQlrVbs81JEZQsoKEIzrW6HcmePewUi++BtrcoPZI+FbtFiSqMqq/l6rzcOsCwdhqY0HOPDkm1yK92CRX0/oOTsMUR26KjAblliqxYZthQF3xeAy643st8wOYmsXhWI7zxT+zokgBNU/pCwouck0GALnL3pc2ZJ1P/Q5P1R0BodRS9HpwaHmGurHaY0y0Clndwb9c+3Sim5nA5qPwYT3BxX7NxFsuDYKReiY/CnN715JuQdvrwR5gdv8PNniNeZiH0zg3Iz5LUWug4V/h9nG7tGQbpIs4R0iKq8dQ0qvzKp3MKAz99BYdPgl6+pV6TTD9EndoK+NAOxKC8kD3/NELwOA2NU/vHEc7V8ZC2eT+OZIzxVJGmWtkLrACvf2mtMylYH8hBMT4kQdruoryPoiVxf8XBiGTmxQPfrMOgUjE1Ywr0c1DAzOp9qfU6nH/GJv8zA5hiTEqVoRLqiratlh2G2oyoXkhL4Sn+tni7vPtdSMP5u3eTwsl/OWH6jAMIEGs3fyC/2pGV+EkfcywOrDm2SfdaOzGv7cLmYtAYyvUy32tTkURCrOhuW5Vd5QyAKFFjJG6c8NIug2VsGoPIcEugBUCZSePSwvgi6eybhv49q9KxcBDOX7daTxxHgqehyzj4GId63eLuy6Dw/2y2ULe26L0D/fSsU7SR/HxfvL8HzpDmAZWr1lGWFPs7QM3kkMDsH9Sh7h/+lslQf+BRhS4z1n5rk+aNQpml/gbZTVqyO4c9fSYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(54906003)(110136005)(7636003)(82740400003)(478600001)(356005)(41300700001)(8676002)(8936002)(4326008)(70206006)(70586007)(2616005)(316002)(16526019)(186003)(36860700001)(336012)(426003)(47076005)(83380400001)(966005)(6666004)(107886003)(26005)(1076003)(82310400005)(86362001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:15:46.7706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3278b62-aa0c-4ab5-b491-08db66cad06c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
Subject: [virtio-dev] [PATCH v4 3/3] transport-pci: Add legacy register access conformance section

Add device and driver conformanace section for legacy registers access
commands interface.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v3->v4:
- moved legacy interface normative references to legacy conformance
  section
v2->v3:
- added normative lines for two additional commands
---
 conformance.tex               |  2 ++
 transport-pci-legacy-regs.tex | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..be0bf89 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -265,6 +265,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
+\item Section \ref{par:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: SR-IOV VFs Registers Access}
+\item Section \ref{par:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: Notification capability}
 \item Section \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
 \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Setting the Virtio Revision / Legacy Interfaces: A Note on Setting the Virtio Revision}
 \item Section \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}
diff --git a/transport-pci-legacy-regs.tex b/transport-pci-legacy-regs.tex
index 2a464da..ef6a33c 100644
--- a/transport-pci-legacy-regs.tex
+++ b/transport-pci-legacy-regs.tex
@@ -120,3 +120,36 @@ \subsubsection{Legacy Device Registers Read Command}\label{sec:Virtio Transport
 	u8 registers[];
 };
 \end{lstlisting}
+
+\paragraph{Legacy Interfaces Requirements: SR-IOV VFs Legacy Registers Access}\label{par:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: SR-IOV VFs Registers Access}
+
+If the PCI PF device supports legacy registers access for its group members,
+the device MUST set all corresponding bits for commands VIRTIO_ADMIN_CMD_LCC_REG_WRITE,
+VIRTIO_ADMIN_CMD_LCC_REG_READ, VIRTIO_ADMIN_CMD_LD_REG_WRITE,
+VIRTIO_ADMIN_CMD_LD_REG_READ in the command result of
+VIRTIO_ADMIN_CMD_LIST_QUERY in \field{device_admin_cmd_opcodes}.
+
+The device MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LCC_REG_WRITE, VIRTIO_ADMIN_CMD_LCC_REG_READ
+commands for the invalid offset which is outside the legacy common configuration
+register's address range.
+
+The device MUST fail VIRTIO_ADMIN_CMD_LD_REG_WRITE, VIRTIO_ADMIN_CMD_LD_REG_READ
+commands for the invalid offset which is outside the legacy device specific
+register's address range.
+
+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to support
+legacy interface registers access.
+
+The driver MUST encode and decode legacy device specific registers using
+little-endian format.
+
+The driver SHOULD send VIRTIO_ADMIN_CMD_LCC_REG_WRITE and
+VIRTIO_ADMIN_CMD_LCC_REG_READ commands with a valid offset which is in the
+legacy common configuration registers address range.
+
+The driver SHOULD send commands VIRTIO_ADMIN_CMD_LD_REG_WRITE and
+VIRTIO_ADMIN_CMD_LD_REG_READ with a valid offset which is in the legacy
+device specific registers address range.
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

